SUBSYSTEM_DEF(garbage)
	name = "Garbage"
	priority = SS_PRIORITY_GARBAGE
	wait = 2 SECONDS
	flags = SS_POST_FIRE_TIMING|SS_BACKGROUND|SS_NO_INIT
	runlevels = RUNLEVELS_DEFAULT | RUNLEVEL_LOBBY

	var/list/collection_timeout = list(0, 2 MINUTES, 10 SECONDS)	// deciseconds to wait before moving something up in the queue to the next level

	//Stat tracking
	var/delslasttick = 0            // number of del()'s we've done this tick
	var/gcedlasttick = 0            // number of things that gc'ed last tick
	var/totaldels = 0
	var/totalgcs = 0

	var/highest_del_time = 0
	var/highest_del_tickusage = 0

	var/list/pass_counts
	var/list/fail_counts

	var/list/items = list()         // Holds our qdel_item statistics datums

	//Queue
	var/list/queues


/datum/controller/subsystem/garbage/PreInit()
	queues = new(GC_QUEUE_COUNT)
	pass_counts = new(GC_QUEUE_COUNT)
	fail_counts = new(GC_QUEUE_COUNT)
	for(var/i in 1 to GC_QUEUE_COUNT)
		queues[i] = list()
		pass_counts[i] = 0
		fail_counts[i] = 0

/datum/controller/subsystem/garbage/stat_entry(msg)
	var/list/counts = list()
	for (var/list/L in queues)
		counts += length(L)
	msg += "Q:[counts.Join(",")]|D:[delslasttick]|G:[gcedlasttick]|"
	msg += "GR:"
	if (!(delslasttick+gcedlasttick))
		msg += "n/a|"
	else
		msg += "[round((gcedlasttick/(delslasttick+gcedlasttick))*100, 0.01)]%|"

	msg += "TD:[totaldels]|TG:[totalgcs]|"
	if (!(totaldels+totalgcs))
		msg += "n/a|"
	else
		msg += "TGR:[round((totalgcs/(totaldels+totalgcs))*100, 0.01)]%"
	msg += " P:[pass_counts.Join(",")]"
	msg += "|F:[fail_counts.Join(",")]"
	..(msg)

/datum/controller/subsystem/garbage/Shutdown()
	//Adds the del() log to the qdel log file
	var/list/dellog = list()

	//sort by how long it's wasted hard deleting
	sortTim(items, cmp=/proc/cmp_qdel_item_time, associative = TRUE)
	for(var/path in items)
		var/datum/qdel_item/I = items[path]
		dellog += "Path: [path]"
		if (I.failures)
			dellog += "\tFailures: [I.failures]"
		dellog += "\tqdel() Count: [I.qdels]"
		dellog += "\tDestroy() Cost: [I.destroy_time]ms"
		if (I.hard_deletes)
			dellog += "\tTotal Hard Deletes [I.hard_deletes]"
			dellog += "\tTime Spent Hard Deleting: [I.hard_delete_time]ms"
		if (I.slept_destroy)
			dellog += "\tSleeps: [I.slept_destroy]"
		if (I.no_respect_force)
			dellog += "\tIgnored force: [I.no_respect_force] times"
		if (I.no_hint)
			dellog += "\tNo hint: [I.no_hint] times"
	log_qdel(dellog.Join("\n"))

/datum/controller/subsystem/garbage/fire()
	//the fact that this resets its processing each fire (rather then resume where it left off) is intentional.
	var/queue = GC_QUEUE_PREQUEUE

	while (state == SS_RUNNING)
		switch (queue)
			if (GC_QUEUE_PREQUEUE)
				HandlePreQueue()
				queue = GC_QUEUE_PREQUEUE+1
			if (GC_QUEUE_CHECK)
				HandleQueue(GC_QUEUE_CHECK)
				queue = GC_QUEUE_CHECK+1
			if (GC_QUEUE_HARDDELETE)
				HandleQueue(GC_QUEUE_HARDDELETE)
				break

	if (state == SS_PAUSED) //make us wait again before the next run.
		state = SS_RUNNING

//If you see this proc high on the profile, what you are really seeing is the garbage collection/soft delete overhead in byond.
//Don't attempt to optimize, not worth the effort.
/datum/controller/subsystem/garbage/proc/HandlePreQueue()
	var/list/tobequeued = queues[GC_QUEUE_PREQUEUE]
	var/static/count = 0
	if (count)
		var/c = count
		count = 0 //so if we runtime on the Cut, we don't try again.
		tobequeued.Cut(1,c+1)

	for (var/ref in tobequeued)
		count++
		Queue(ref, GC_QUEUE_PREQUEUE+1)
		if (MC_TICK_CHECK)
			break
	if (count)
		tobequeued.Cut(1,count+1)
		count = 0

/datum/controller/subsystem/garbage/proc/HandleQueue(level = GC_QUEUE_CHECK)
	if (level == GC_QUEUE_CHECK)
		delslasttick = 0
		gcedlasttick = 0
	var/cut_off_time = world.time - collection_timeout[level] //ignore entries newer then this
	var/list/queue = queues[level]
	var/static/lastlevel
	var/static/count = 0
	if (count) //runtime last run before we could do this.
		var/c = count
		count = 0 //so if we runtime on the Cut, we don't try again.
		var/list/lastqueue = queues[lastlevel]
		lastqueue.Cut(1, c+1)

	lastlevel = level

	for (var/refID in queue)
		if (!refID)
			count++
			if (MC_TICK_CHECK)
				break
			continue

		var/GCd_at_time = queue[refID]
		if(GCd_at_time > cut_off_time)
			break // Everything else is newer, skip them
		count++

		var/datum/D
		D = locate(refID)

		if (!D || D.gc_destroyed != GCd_at_time) // So if something else coincidently gets the same ref, it's not deleted by mistake
			++gcedlasttick
			++totalgcs
			pass_counts[level]++
			if (MC_TICK_CHECK)
				break
			continue

		// Something's still referring to the qdel'd object.
		fail_counts[level]++
		switch (level)
			if (GC_QUEUE_CHECK)
				#ifdef GC_FAILURE_HARD_LOOKUP
				D.find_references()
				#endif
				var/type = D.type
				var/datum/qdel_item/I = items[type]
				if(!I.failures)
					var/msg = "GC: -- \ref[D] | [type] was unable to be GC'd --"
					if(I.coords)
						msg += "GC: -- \ref[D] | location is X=[I.coords.x_pos], Y=[I.coords.y_pos], Z=[I.coords.z_pos] --"
					log_to_dd(msg)
				I.failures++
			if (GC_QUEUE_HARDDELETE)
				HardDelete(D)
				if (MC_TICK_CHECK)
					break
				continue

		Queue(D, level+1)

		if (MC_TICK_CHECK)
			break
	if (count)
		queue.Cut(1,count+1)
		count = 0

/datum/controller/subsystem/garbage/proc/PreQueue(datum/D)
	if (D.gc_destroyed == GC_CURRENTLY_BEING_QDELETED)
		queues[GC_QUEUE_PREQUEUE] += D
		D.gc_destroyed = GC_QUEUED_FOR_QUEUING

/datum/controller/subsystem/garbage/proc/Queue(datum/D, level = GC_QUEUE_CHECK)
	if (isnull(D))
		return
	if (D.gc_destroyed == GC_QUEUED_FOR_HARD_DEL)
		level = GC_QUEUE_HARDDELETE
	if (level > GC_QUEUE_COUNT)
		HardDelete(D)
		return
	var/gctime = world.time
	var/refid = "\ref[D]"

	D.gc_destroyed = gctime
	var/list/queue = queues[level]
	if (queue[refid])
		queue -= refid // Removing any previous references that were GC'd so that the current object will be at the end of the list.

	queue[refid] = gctime

//this is mainly to separate things profile wise.
/datum/controller/subsystem/garbage/proc/HardDelete(datum/D)
	var/time = world.timeofday
	var/tick = TICK_USAGE
	var/ticktime = world.time
	++delslasttick
	++totaldels
	var/type = D.type
	var/refID = "\ref[D]"

	del(D)

	tick = (TICK_USAGE-tick+((world.time-ticktime)/world.tick_lag*100))

	var/datum/qdel_item/I = items[type]

	I.hard_deletes++
	I.hard_delete_time += TICK_DELTA_TO_MS(tick)


	if (tick > highest_del_tickusage)
		highest_del_tickusage = tick
	time = world.timeofday - time
	if (!time && TICK_DELTA_TO_MS(tick) > 1)
		time = TICK_DELTA_TO_MS(tick)/100
	if (time > highest_del_time)
		highest_del_time = time
	if (time > 10)
		log_game("Error: [type]([refID]) took longer than 1 second to delete (took [time/10] seconds to delete)")
		message_admins("Error: [type]([refID]) took longer than 1 second to delete (took [time/10] seconds to delete).")
		postpone(time)

/datum/controller/subsystem/garbage/proc/HardQueue(datum/D)
	if (D.gc_destroyed == GC_CURRENTLY_BEING_QDELETED)
		queues[GC_QUEUE_PREQUEUE] += D
		D.gc_destroyed = GC_QUEUED_FOR_HARD_DEL

/datum/controller/subsystem/garbage/Recover()
	if (istype(SSgarbage.queues))
		for (var/i in 1 to SSgarbage.queues.len)
			queues[i] |= SSgarbage.queues[i]










//DEBUG procs
/******************************************/
/datum/controller/subsystem/garbage/proc/purge()
	//An emergency proc that attempts to resolve broken GC by hard-deling everything that's queued
	for (var/d in queues[GC_QUEUE_PREQUEUE])
		del(d)

	queues[GC_QUEUE_PREQUEUE] = list()

	for (var/d in queues[GC_QUEUE_CHECK])
		var/datum/e = locate(d)
		if (e)
			del(e)

	queues[GC_QUEUE_CHECK] = list()

ADMIN_VERB_ADD(/client/proc/GCDebugItems, R_DEBUG, FALSE)
/client/proc/GCDebugItems()
	set category = "Debug"
	set name = "GCDebugItems"
	if(!check_rights(R_DEBUG))	return

	var/data = "-----------------------<br>"
	var/list/totals = list()
	for (var/a in SSgarbage.items)
		var/datum/qdel_item/qi = SSgarbage.items[a]
		totals[a] = qi.qdels

	var/list/sorted = sortAssoc(totals)

	for (var/b in sorted)
		data += "[b]: [totals[b]]<br>"
	usr << browse(data,"window=GCItems")

ADMIN_VERB_ADD(/client/proc/GCDebugPreQueue, R_DEBUG, FALSE)
/client/proc/GCDebugPreQueue()
	set category = "Debug"
	set name = "GCDebugPreQueue"
	if(!check_rights(R_DEBUG))	return
	var/depth = input(usr, "How many elements to search?", "GC Queue", 1000) as num

	var/list/totals = list()
	var/data = "-----------------------<br>"
	var/list/a = SSgarbage.queues[GC_QUEUE_PREQUEUE]
	if (a && a.len)
		for (var/i = 1; i <= depth; i++)
			if (i > a.len)
				break
			var/datum/c = a[i]

			if (totals[c.type])
				totals[c.type]++
			else
				totals[c.type] = 1

	var/list/sorted = sortAssoc(totals)

	for (var/b in sorted)
		data += "[b]: [totals[b]]<br>"

	usr << browse(data,"window=GCQueue")


ADMIN_VERB_ADD(/client/proc/GCDebugQueue, R_DEBUG, FALSE)
/client/proc/GCDebugQueue()
	set category = "Debug"
	set name = "GCDebugQueue"
	if(!check_rights(R_DEBUG))	return
	var/depth = input(usr, "How many elements to search?", "GC Queue", 1000) as num

	var/list/totals = list()
	var/data = "-----------------------<br>"
	var/list/a = SSgarbage.queues[GC_QUEUE_CHECK]
	if (a && a.len)
		for (var/i = 1; i <= depth; i++)
			if (i > a.len)
				break
			var/datum/c = locate(a[i])

			if (!c)
				continue

			if (totals[c.type])
				totals[c.type]++
			else
				totals[c.type] = 1

	var/list/sorted = sortAssoc(totals)

	for (var/b in sorted)
		data += "[b]: [totals[b]]<br>"

	usr << browse(data,"window=GCQueue")



ADMIN_VERB_ADD(/client/proc/GCDebugQueueNS, R_DEBUG, FALSE)
/client/proc/GCDebugQueueNS()
	set category = "Debug"
	set name = "GCDebugQueueNS"
	if(!check_rights(R_DEBUG))	return
	var/depth = input(usr, "How many elements to search?", "GC Queue", 1000) as num

	var/list/totals = list()
	var/data = ""
	var/list/a = SSgarbage.queues[GC_QUEUE_CHECK]
	if (a && a.len)
		for (var/i = 1; i <= depth; i++)
			if (i > a.len)
				break
			var/datum/c = locate(a[i])

			if (!c)
				continue

			if (totals[c.type])
				totals[c.type]++
			else
				totals[c.type] = 1

	//totals = sortAssoc(totals)

	for (var/b in totals)
		data += "[b]: [totals[b]]<br>"

	usr << browse(data,"window=GCQueue")







/******************************************/






/datum/qdel_item
	var/name = ""
	var/qdels = 0			//Total number of times it's passed thru qdel.
	var/destroy_time = 0	//Total amount of milliseconds spent processing this type's Destroy()
	var/failures = 0		//Times it was queued for soft deletion but failed to soft delete.
	var/hard_deletes = 0 	//Different from failures because it also includes QDEL_HINT_HARDDEL deletions
	var/hard_delete_time = 0//Total amount of milliseconds spent hard deleting this type.
	var/no_respect_force = 0//Number of times it's not respected force=TRUE
	var/no_hint = 0			//Number of times it's not even bother to give a qdel hint
	var/slept_destroy = 0	//Number of times it's slept in its destroy
	var/datum/coords/coords //Coordinates of item (if its an atom)

/datum/qdel_item/New(mytype)
	name = "[mytype]"


// Should be treated as a replacement for the 'del' keyword.
// Datums passed to this will be given a chance to clean up references to allow the GC to collect them.
/proc/qdel(datum/D, force=FALSE)
	if(!D)
		return
	if(!istype(D))
		crash_with("qdel() can only handle /datum (sub)types, was passed: [log_info_line(D)]")
		del(D)
		return
	var/datum/qdel_item/I = SSgarbage.items[D.type]
	if (!I)
		I = SSgarbage.items[D.type] = new /datum/qdel_item(D.type)
	I.qdels++

	if(istype(D,/atom))
		var/atom/A = D
		I.coords = A.get_coords()

	if(isnull(D.gc_destroyed))
		D.gc_destroyed = GC_CURRENTLY_BEING_QDELETED
		var/start_time = world.time
		var/start_tick = world.tick_usage
		var/hint = D.Destroy(force) // Let our friend know they're about to get fucked up.
		if(world.time != start_time)
			I.slept_destroy++
		else
			I.destroy_time += TICK_USAGE_TO_MS(start_tick)
		if(!D)
			return
		switch(hint)
			if (QDEL_HINT_QUEUE)		//qdel should queue the object for deletion.
				SSgarbage.PreQueue(D)
			if (QDEL_HINT_IWILLGC)
				D.gc_destroyed = world.time
				return
			if (QDEL_HINT_LETMELIVE)	//qdel should let the object live after calling destory.
				if(!force)
					D.gc_destroyed = null //clear the gc variable (important!)
					return
				// Returning LETMELIVE after being told to force destroy
				// indicates the objects Destroy() does not respect force
				if(!I.no_respect_force)
					crash_with("WARNING: [D.type] has been force deleted, but is \
						returning an immortal QDEL_HINT, indicating it does \
						not respect the force flag for qdel(). It has been \
						placed in the queue, further instances of this type \
						will also be queued.")
				I.no_respect_force++

				SSgarbage.PreQueue(D)
			if (QDEL_HINT_HARDDEL)		//qdel should assume this object won't gc, and queue a hard delete using a hard reference to save time from the locate()
				SSgarbage.HardQueue(D)
			if (QDEL_HINT_HARDDEL_NOW)	//qdel should assume this object won't gc, and hard del it post haste.
				SSgarbage.HardDelete(D)
			if (QDEL_HINT_FINDREFERENCE)//qdel will, if TESTING is enabled, display all references to this object, then queue the object for deletion.
				SSgarbage.PreQueue(D)
				#ifdef TESTING
				D.find_references()
				#endif
			else
				if(!I.no_hint)
					crash_with("WARNING: [D.type] is not returning a qdel hint. It is being placed in the queue. Further instances of this type will also be queued.")
				I.no_hint++
				SSgarbage.PreQueue(D)
	else if(D.gc_destroyed == GC_CURRENTLY_BEING_QDELETED)
		CRASH("[D.type] destroy proc was called multiple times, likely due to a qdel loop in the Destroy logic")



#ifdef TESTING

/datum/verb/find_refs()
	set category = "Debug"
	set name = "Find References"
	set background = 1
	set src in world

	find_references(FALSE)

/datum/proc/find_references(skip_alert)
	running_find_references = type
	if(usr && usr.client)
		if(usr.client.running_find_references)
			testing("CANCELLED search for references to a [usr.client.running_find_references].")
			usr.client.running_find_references = null
			running_find_references = null
			//restart the garbage collector
			SSgarbage.can_fire = 1
			SSgarbage.next_fire = world.time + world.tick_lag
			return

		if(!skip_alert)
			if(alert("Running this will lock everything up for about 5 minutes.  Would you like to begin the search?", "Find References", "Yes", "No") == "No")
				running_find_references = null
				return

	//this keeps the garbage collector from failing to collect objects being searched for in here
	SSgarbage.can_fire = 0

	if(usr && usr.client)
		usr.client.running_find_references = type

	testing("Beginning search for references to a [type].")
	last_find_references = world.time
	DoSearchVar(GLOB)
	for(var/datum/thing in world)
		DoSearchVar(thing, "WorldRef: [thing]")
	testing("Completed search for references to a [type].")
	if(usr && usr.client)
		usr.client.running_find_references = null
	running_find_references = null

	//restart the garbage collector
	SSgarbage.can_fire = 1
	SSgarbage.next_fire = world.time + world.tick_lag

/datum/verb/qdel_then_find_references()
	set category = "Debug"
	set name = "qdel() then Find References"
	set background = 1
	set src in world

	qdel(src)
	if(!running_find_references)
		find_references(TRUE)

/datum/proc/DoSearchVar(X, Xname)
	if(usr && usr.client && !usr.client.running_find_references) return
	if(istype(X, /datum))
		var/datum/D = X
		if(D.last_find_references == last_find_references)
			return
		D.last_find_references = last_find_references
		for(var/V in D.vars)
			for(var/varname in D.vars)
				var/variable = D.vars[varname]
				if(variable == src)
					testing("Found [src.type] \ref[src] in [D.type]'s [varname] var. [Xname]")
				else if(islist(variable))
					if(src in variable)
						testing("Found [src.type] \ref[src] in [D.type]'s [varname] list var. Global: [Xname]")
#ifdef GC_FAILURE_HARD_LOOKUP
					for(var/I in variable)
						DoSearchVar(I, TRUE)
				else
					DoSearchVar(variable, "[Xname]: [varname]")
#endif
	else if(islist(X))
		if(src in X)
			testing("Found [src.type] \ref[src] in list [Xname].")
#ifdef GC_FAILURE_HARD_LOOKUP
		for(var/I in X)
			DoSearchVar(I, Xname + ": list")
#else
	CHECK_TICK
#endif

#endif
