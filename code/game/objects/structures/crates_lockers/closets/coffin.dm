/obj/structure/closet/coffin
	name = "coffin"
	desc = "It's a burial receptacle for the dearly departed."
	icon_state = "coffin"
	var/mob/living/occupant = null

/obj/structure/closet/coffin/close(mob/living/user)
	..()
	for (var/mob/living/L in contents)
		//When the coffin is closed we check for mobs in it.
		if (L.mind && L.mind.key)
			//We won't check if the mob is dead yet, maybe being spaced in a coffin is an execution method
			occupant = L
			break

//The coffin processes when there's a mob inside
/obj/structure/closet/coffin/lost_in_space()
	//The coffin has left the ship. Burial at space
	if (occupant && occupant.is_dead())
		var/mob/M = key2mob(occupant.mind.key)
		//We send a message to the occupant's current mob - probably a ghost, but who knows.
		to_chat(M, SPAN_NOTICE("Your remains have been committed to the void. Your crew respawn time has been reduced by 15 minutes."))
		M << 'sound/effects/magic/blind.ogg' //Play this sound to a player whenever their respawn time gets reduced

		//A proper funeral for the corpse allows a faster respawn
		M.set_respawn_bonus("CORPSE_HANDLING", 15 MINUTES)

		qdel(occupant)
		qdel(src)

	return TRUE

/obj/structure/closet/coffin/Destroy()
	occupant = null
	return ..()

/obj/structure/closet/coffin/spawnercorpse
	name = "coffin"
	desc = "It's a burial receptacle for the dearly departed."
	icon_state = "coffin"
	welded = 1

/obj/structure/closet/coffin/spawnercorpse/New()
	..()
	var/atom/A = pick(/obj/landmark/corpse/roles/civilian/chef, \
					  /obj/landmark/corpse/roles/medical/moebiusdoctor, \
					  /obj/landmark/corpse/roles/engineering/technomancer, \
					  /obj/landmark/corpse/roles/engineering/technomancer/voidsuit, \
					  /obj/landmark/corpse/generic/clown, \
					  /obj/landmark/corpse/roles/research/moebiusscientist, \
					  /obj/landmark/corpse/roles/cargo/guildminer, \
					  /obj/landmark/corpse/roles/cargo/guildminer/voidsuit, \
					  /obj/landmark/corpse/roles/command/firstofficer, \
					  /obj/landmark/corpse/roles/command/captain, \
					  /obj/landmark/corpse/antagonist/russian)
	new A