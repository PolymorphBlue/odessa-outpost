/*
 *	Everything derived from the common cardboard box.
 *	Basically everything except the original is a kit (starts full).
 *
 *	Contains:
 *		Empty box, starter boxes (survival/engineer),
 *		Latex glove and sterile mask boxes,
 *		Syringe, beaker, dna injector boxes,
 *		Blanks, flashbangs, and EMP grenade boxes,
 *		Tracking and chemical implant boxes,
 *		Prescription glasses and drinking glass boxes,
 *		Condiment bottle and silly cup boxes,
 *		Donkpocket and monkeycube boxes,
 *		ID and security PDA cart boxes,
 *		Handcuff, mousetrap, and pillbottle boxes,
 *		Snap-pops and matchboxes,
 *		Replacement light boxes.
 *
 *		For syndicate call-ins see uplink_kits.dm
 */

/obj/item/weapon/storage/box
	name = "box"
	desc = "It's just an ordinary box."
	icon_state = "box"
	item_state = "syringe_kit"
	var/foldable = /obj/item/stack/material/cardboard	// BubbleWrap - if set, can be folded (when empty) into a sheet of cardboard
	var/maxHealth = 20	//health is already defined

/obj/item/weapon/storage/box/Initialize()
	health = maxHealth
	.=..()

/obj/item/weapon/storage/box/proc/damage(var/severity)
	health -= severity
	check_health()

/obj/item/weapon/storage/box/proc/check_health()
	if (health <= 0)
		spill()
		qdel(src)

/obj/item/weapon/storage/box/attack_generic(var/mob/user)
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN*2)
	if (istype(user, /mob/living))
		var/mob/living/L = user
		var/damage
		if (!L.mob_size)
			damage = 3//A safety incase i forgot to set a mob_size on something
		else
			damage = L.mob_size//he bigger you are, the faster it tears

		if (!damage || damage <= 0)
			return

		user.do_attack_animation(src)

		var/toplay = pick(list('sound/effects/creatures/nibble1.ogg','sound/effects/creatures/nibble2.ogg'))
		playsound(loc, toplay, 50, 1, 2)
		shake_animation()
		sleep(5)
		if ((health-damage) <= 0)
			L.visible_message("<span class='danger'>[L] tears open the [src], spilling its contents everywhere!</span>", "<span class='danger'>You tear open the [src], spilling its contents everywhere!</span>")
		damage(damage)
	..()

// BubbleWrap - A box can be folded up to make card
/obj/item/weapon/storage/box/attack_self(mob/user as mob)
	if(..()) return

	//try to fold it.
	if ( contents.len )
		return

	if ( !ispath(src.foldable) )
		return

	// Close any open UI windows first
	close_all()

	// Now make the cardboard
	to_chat(user, SPAN_NOTICE("You fold [src] flat."))
	new src.foldable(get_turf(src))
	qdel(src)

/obj/item/weapon/storage/box/survival/
	New()
		..()
		new /obj/item/clothing/mask/breath( src )
		new /obj/item/weapon/tank/emergency_oxygen( src )

/obj/item/weapon/storage/box/engineer/
	New()
		..()
		new /obj/item/clothing/mask/breath( src )
		new /obj/item/weapon/tank/emergency_oxygen/engi( src )

/obj/item/weapon/storage/box/gloves
	name = "box of latex gloves"
	desc = "Contains white gloves."
	icon_state = "latex"

	New()
		..()
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/clothing/gloves/latex(src)

/obj/item/weapon/storage/box/masks
	name = "box of sterile masks"
	desc = "This box contains masks of sterility."
	icon_state = "sterile"

	New()
		..()
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)
		new /obj/item/clothing/mask/surgical(src)


/obj/item/weapon/storage/box/syringes
	name = "box of syringes"
	desc = "A box full of syringes."
	icon_state = "syringe"

	New()
		..()
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )
		new /obj/item/weapon/reagent_containers/syringe( src )

/obj/item/weapon/storage/box/syringegun
	name = "box of syringe gun cartridges"
	desc = "A box full of compressed gas cartridges."
	icon_state = "syringe"

	New()
		..()
		new /obj/item/weapon/syringe_cartridge( src )
		new /obj/item/weapon/syringe_cartridge( src )
		new /obj/item/weapon/syringe_cartridge( src )
		new /obj/item/weapon/syringe_cartridge( src )
		new /obj/item/weapon/syringe_cartridge( src )
		new /obj/item/weapon/syringe_cartridge( src )
		new /obj/item/weapon/syringe_cartridge( src )


/obj/item/weapon/storage/box/beakers
	name = "box of beakers"
	icon_state = "beaker"

	New()
		..()
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )
		new /obj/item/weapon/reagent_containers/glass/beaker( src )

/obj/item/weapon/storage/box/injectors
	name = "box of DNA injectors"
	desc = "This box contains injectors it seems."

	New()
		..()
		new /obj/item/weapon/dnainjector/h2m(src)
		new /obj/item/weapon/dnainjector/h2m(src)
		new /obj/item/weapon/dnainjector/h2m(src)
		new /obj/item/weapon/dnainjector/m2h(src)
		new /obj/item/weapon/dnainjector/m2h(src)
		new /obj/item/weapon/dnainjector/m2h(src)

/obj/item/weapon/storage/box/shotgunammo
	name = "box of shotgun slugs"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."
	icon_state = "ammo"

/obj/item/weapon/storage/box/shotgunammo/slug
	name = "box of shotgun slugs"

	New()
		..()
		new /obj/item/ammo_casing/shotgun/prespawned(src)
		new /obj/item/ammo_casing/shotgun/prespawned(src)
		new /obj/item/ammo_casing/shotgun/prespawned(src)
		new /obj/item/ammo_casing/shotgun/prespawned(src)
		new /obj/item/ammo_casing/shotgun/prespawned(src)
		new /obj/item/ammo_casing/shotgun/prespawned(src)
		new /obj/item/ammo_casing/shotgun/prespawned(src)
		for(var/obj/item/ammo_casing/temp_casing in src)
			temp_casing.update_icon()


/obj/item/weapon/storage/box/shotgunammo/blanks
	name = "box of blank shells"

	New()
		..()
		new /obj/item/ammo_casing/shotgun/blank/prespawned(src)
		new /obj/item/ammo_casing/shotgun/blank/prespawned(src)
		new /obj/item/ammo_casing/shotgun/blank/prespawned(src)
		new /obj/item/ammo_casing/shotgun/blank/prespawned(src)
		new /obj/item/ammo_casing/shotgun/blank/prespawned(src)
		new /obj/item/ammo_casing/shotgun/blank/prespawned(src)
		new /obj/item/ammo_casing/shotgun/blank/prespawned(src)
		for(var/obj/item/ammo_casing/temp_casing in src)
			temp_casing.update_icon()

/obj/item/weapon/storage/box/shotgunammo/beanbags
	name = "box of beanbag shells"

	New()
		..()
		new /obj/item/ammo_casing/shotgun/beanbag/prespawned(src)
		new /obj/item/ammo_casing/shotgun/beanbag/prespawned(src)
		new /obj/item/ammo_casing/shotgun/beanbag/prespawned(src)
		new /obj/item/ammo_casing/shotgun/beanbag/prespawned(src)
		new /obj/item/ammo_casing/shotgun/beanbag/prespawned(src)
		new /obj/item/ammo_casing/shotgun/beanbag/prespawned(src)
		new /obj/item/ammo_casing/shotgun/beanbag/prespawned(src)
		for(var/obj/item/ammo_casing/temp_casing in src)
			temp_casing.update_icon()

/obj/item/weapon/storage/box/shotgunammo/buckshot
	name = "box of shotgun shells"

	New()
		..()
		new /obj/item/ammo_casing/shotgun/pellet/prespawned(src)
		new /obj/item/ammo_casing/shotgun/pellet/prespawned(src)
		new /obj/item/ammo_casing/shotgun/pellet/prespawned(src)
		new /obj/item/ammo_casing/shotgun/pellet/prespawned(src)
		new /obj/item/ammo_casing/shotgun/pellet/prespawned(src)
		new /obj/item/ammo_casing/shotgun/pellet/prespawned(src)
		new /obj/item/ammo_casing/shotgun/pellet/prespawned(src)
		for(var/obj/item/ammo_casing/temp_casing in src)
			temp_casing.update_icon()

/obj/item/weapon/storage/box/shotgunammo/flashshells
	name = "box of illumination shells"

	New()
		..()
		new /obj/item/ammo_casing/shotgun/flash/prespawned(src)
		new /obj/item/ammo_casing/shotgun/flash/prespawned(src)
		new /obj/item/ammo_casing/shotgun/flash/prespawned(src)
		new /obj/item/ammo_casing/shotgun/flash/prespawned(src)
		new /obj/item/ammo_casing/shotgun/flash/prespawned(src)
		new /obj/item/ammo_casing/shotgun/flash/prespawned(src)
		new /obj/item/ammo_casing/shotgun/flash/prespawned(src)
		for(var/obj/item/ammo_casing/temp_casing in src)
			temp_casing.update_icon()

/obj/item/weapon/storage/box/shotgunammo/stunshells
	name = "box of stun shells"

	New()
		..()
		new /obj/item/ammo_casing/shotgun/stunshell/prespawned(src)
		new /obj/item/ammo_casing/shotgun/stunshell/prespawned(src)
		new /obj/item/ammo_casing/shotgun/stunshell/prespawned(src)
		new /obj/item/ammo_casing/shotgun/stunshell/prespawned(src)
		new /obj/item/ammo_casing/shotgun/stunshell/prespawned(src)
		new /obj/item/ammo_casing/shotgun/stunshell/prespawned(src)
		new /obj/item/ammo_casing/shotgun/stunshell/prespawned(src)
		for(var/obj/item/ammo_casing/temp_casing in src)
			temp_casing.update_icon()

/obj/item/weapon/storage/box/shotgunammo/practiceshells
	name = "box of practice shells"

	New()
		..()
		new /obj/item/ammo_casing/shotgun/practice/prespawned(src)
		new /obj/item/ammo_casing/shotgun/practice/prespawned(src)
		new /obj/item/ammo_casing/shotgun/practice/prespawned(src)
		new /obj/item/ammo_casing/shotgun/practice/prespawned(src)
		new /obj/item/ammo_casing/shotgun/practice/prespawned(src)
		new /obj/item/ammo_casing/shotgun/practice/prespawned(src)
		new /obj/item/ammo_casing/shotgun/practice/prespawned(src)
		for(var/obj/item/ammo_casing/temp_casing in src)
			temp_casing.update_icon()

/obj/item/weapon/storage/box/sniperammo
	name = "box of 14.5mm shells"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."
	icon_state = "ammo"

	New()
		..()
		new /obj/item/ammo_casing/a145/prespawned(src)
		for(var/obj/item/ammo_casing/temp_casing in src)
			temp_casing.update_icon()

/obj/item/weapon/storage/box/flashbangs
	name = "box of flashbangs"
	desc = "A box containing 7 antipersonnel flashbang grenades.<br> WARNING: These devices are extremely dangerous and can cause blindness or deafness in repeated use."
	icon_state = "flashbang"

	New()
		..()
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/grenade/flashbang(src)

/obj/item/weapon/storage/box/teargas
	name = "box of pepperspray grenades"
	desc = "A box containing 6 tear gas grenades. A gas mask is printed on the label.<br> WARNING: Exposure carries risk of serious injury or death. Keep away from persons with lung conditions."
	icon_state = "flashbang"

	New()
		..()
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)



/obj/item/weapon/storage/box/emps
	name = "box of emp grenades"
	desc = "A box containing 5 military grade EMP grenades.<br> WARNING: Do not use near unshielded electronics or biomechanical augmentations, death or permanent paralysis may occur."
	icon_state = "flashbang"

	New()
		..()
		new /obj/item/weapon/grenade/empgrenade(src)
		new /obj/item/weapon/grenade/empgrenade(src)
		new /obj/item/weapon/grenade/empgrenade(src)
		new /obj/item/weapon/grenade/empgrenade(src)
		new /obj/item/weapon/grenade/empgrenade(src)

/obj/item/weapon/storage/box/frag
	name = "box of fragmentation grenades"
	desc = "A box containing 4 fragmentation grenades. Designed for use on enemies in the open."
	icon_state = "flashbang"

	New()
		..()
		new /obj/item/weapon/grenade/frag(src)
		new /obj/item/weapon/grenade/frag(src)
		new /obj/item/weapon/grenade/frag(src)
		new /obj/item/weapon/grenade/frag(src)

/obj/item/weapon/storage/box/explosive
	name = "box of blast grenades"
	desc = "A box containing 4 blast grenades. Designed for assaulting strongpoints."
	icon_state = "flashbang"

	New()
		..()
		new /obj/item/weapon/grenade/frag/explosive(src)
		new /obj/item/weapon/grenade/frag/explosive(src)
		new /obj/item/weapon/grenade/frag/explosive(src)
		new /obj/item/weapon/grenade/frag/explosive(src)


/obj/item/weapon/storage/box/smokes
	name = "box of smoke bombs"
	desc = "A box containing 5 smoke bombs."
	icon_state = "flashbang"

/obj/item/weapon/storage/box/smokes/New()
		..()
		new /obj/item/weapon/grenade/smokebomb(src)
		new /obj/item/weapon/grenade/smokebomb(src)
		new /obj/item/weapon/grenade/smokebomb(src)
		new /obj/item/weapon/grenade/smokebomb(src)
		new /obj/item/weapon/grenade/smokebomb(src)

/obj/item/weapon/storage/box/anti_photons
	name = "box of anti-photon grenades"
	desc = "A box containing 5 experimental photon disruption grenades."
	icon_state = "flashbang"

/obj/item/weapon/storage/box/anti_photons/New()
		..()
		new /obj/item/weapon/grenade/anti_photon(src)
		new /obj/item/weapon/grenade/anti_photon(src)
		new /obj/item/weapon/grenade/anti_photon(src)
		new /obj/item/weapon/grenade/anti_photon(src)
		new /obj/item/weapon/grenade/anti_photon(src)

/obj/item/weapon/storage/box/trackimp
	name = "boxed tracking implant kit"
	desc = "Box full of scum-bag tracking utensils."
	icon_state = "implant"

	New()
		..()
		new /obj/item/weapon/implantcase/tracking(src)
		new /obj/item/weapon/implantcase/tracking(src)
		new /obj/item/weapon/implantcase/tracking(src)
		new /obj/item/weapon/implantcase/tracking(src)
		new /obj/item/weapon/implanter(src)
		new /obj/item/weapon/implantpad(src)
		new /obj/item/weapon/locator(src)

/obj/item/weapon/storage/box/chemimp
	name = "boxed chemical implant kit"
	desc = "Box of stuff used to implant chemicals."
	icon_state = "implant"

	New()
		..()
		new /obj/item/weapon/implantcase/chem(src)
		new /obj/item/weapon/implantcase/chem(src)
		new /obj/item/weapon/implantcase/chem(src)
		new /obj/item/weapon/implantcase/chem(src)
		new /obj/item/weapon/implantcase/chem(src)
		new /obj/item/weapon/implanter(src)
		new /obj/item/weapon/implantpad(src)



/obj/item/weapon/storage/box/rxglasses
	name = "box of prescription glasses"
	desc = "This box contains nerd glasses."
	icon_state = "glasses"

	New()
		..()
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/clothing/glasses/regular(src)

/obj/item/weapon/storage/box/drinkingglasses
	name = "box of drinking glasses"
	desc = "It has a picture of drinking glasses on it."

	New()
		..()
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(src)

/obj/item/weapon/storage/box/cdeathalarm_kit
	name = "death alarm kit"
	desc = "Box of stuff used to implant death alarms."
	icon_state = "implant"
	item_state = "syringe_kit"

	New()
		..()
		new /obj/item/weapon/implanter(src)
		new /obj/item/weapon/implantcase/death_alarm(src)
		new /obj/item/weapon/implantcase/death_alarm(src)
		new /obj/item/weapon/implantcase/death_alarm(src)
		new /obj/item/weapon/implantcase/death_alarm(src)
		new /obj/item/weapon/implantcase/death_alarm(src)
		new /obj/item/weapon/implantcase/death_alarm(src)

/obj/item/weapon/storage/box/flares
	name = "box of flares"
	desc = "Box that contains some flares."
	icon_state = "flare"

	New()
		..()
		new /obj/item/device/lighting/glowstick/flare(src)
		new /obj/item/device/lighting/glowstick/flare(src)
		new /obj/item/device/lighting/glowstick/flare(src)
		new /obj/item/device/lighting/glowstick/flare(src)
		new /obj/item/device/lighting/glowstick/flare(src)
		new /obj/item/device/lighting/glowstick/flare(src)
		new /obj/item/device/lighting/glowstick/flare(src)

/obj/item/weapon/storage/box/condimentbottles
	name = "box of condiment bottles"
	desc = "It has a large ketchup smear on it."

	New()
		..()
		new /obj/item/weapon/reagent_containers/food/condiment(src)
		new /obj/item/weapon/reagent_containers/food/condiment(src)
		new /obj/item/weapon/reagent_containers/food/condiment(src)
		new /obj/item/weapon/reagent_containers/food/condiment(src)
		new /obj/item/weapon/reagent_containers/food/condiment(src)
		new /obj/item/weapon/reagent_containers/food/condiment(src)



/obj/item/weapon/storage/box/cups
	name = "box of paper cups"
	desc = "It has pictures of paper cups on the front."
	New()
		..()
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup( src )


/obj/item/weapon/storage/box/donkpockets
	name = "box of donk-pockets"
	desc = "<B>Instructions:</B> <I>Heat in microwave. Product will cool if not eaten within seven minutes.</I>"
	icon_state = "donk_kit"

	New()
		..()
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(src)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(src)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(src)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(src)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(src)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(src)

/obj/item/weapon/storage/box/sinpockets
	name = "box of sin-pockets"
	desc = "<B>Instructions:</B> <I>Crush bottom of package to initiate chemical heating. Wait for 20 seconds before consumption. Product will cool if not eaten within seven minutes.</I>"
	icon_state = "donk_kit"

	New()
		..()
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket/sinpocket(src)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket/sinpocket(src)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket/sinpocket(src)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket/sinpocket(src)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket/sinpocket(src)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket/sinpocket(src)

/obj/item/weapon/storage/box/monkeycubes
	name = "monkey cube box"
	desc = "Drymate brand monkey cubes. Just add water!"
	icon = 'icons/obj/food.dmi'
	icon_state = "monkeycubebox"
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/monkeycube)
	New()
		..()
		if(src.type == /obj/item/weapon/storage/box/monkeycubes)
			for(var/i = 1; i <= 5; i++)
				new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(src)

/obj/item/weapon/storage/box/ids
	name = "box of spare IDs"
	desc = "Has so many empty IDs."
	icon_state = "id"

	New()
		..()
		new /obj/item/weapon/card/id(src)
		new /obj/item/weapon/card/id(src)
		new /obj/item/weapon/card/id(src)
		new /obj/item/weapon/card/id(src)
		new /obj/item/weapon/card/id(src)
		new /obj/item/weapon/card/id(src)
		new /obj/item/weapon/card/id(src)


/obj/item/weapon/storage/box/seccarts
	name = "box of spare R.O.B.U.S.T. Cartridges"
	desc = "A box full of R.O.B.U.S.T. Cartridges, used by Security."
	icon_state = "pda"

	New()
		..()
		new /obj/item/weapon/cartridge/security(src)
		new /obj/item/weapon/cartridge/security(src)
		new /obj/item/weapon/cartridge/security(src)
		new /obj/item/weapon/cartridge/security(src)
		new /obj/item/weapon/cartridge/security(src)
		new /obj/item/weapon/cartridge/security(src)
		new /obj/item/weapon/cartridge/security(src)


/obj/item/weapon/storage/box/handcuffs
	name = "box of spare handcuffs"
	desc = "A box full of handcuffs."
	icon_state = "handcuff"

	New()
		..()
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)
		new /obj/item/weapon/handcuffs(src)


/obj/item/weapon/storage/box/mousetraps
	name = "box of Pest-B-Gon mousetraps"
	desc = "<B><FONT color='red'>WARNING:</FONT></B> <I>Keep out of reach of children</I>."
	icon_state = "mousetraps"

	New()
		..()
		new /obj/item/device/assembly/mousetrap( src )
		new /obj/item/device/assembly/mousetrap( src )
		new /obj/item/device/assembly/mousetrap( src )
		new /obj/item/device/assembly/mousetrap( src )
		new /obj/item/device/assembly/mousetrap( src )
		new /obj/item/device/assembly/mousetrap( src )

/obj/item/weapon/storage/box/pillbottles
	name = "box of pill bottles"
	desc = "It has pictures of pill bottles on its front."

	New()
		..()
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )
		new /obj/item/weapon/storage/pill_bottle( src )


/obj/item/weapon/storage/box/snappops
	name = "snap pop box"
	desc = "Eight wrappers of fun! Ages 8 and up. Not suitable for children."
	icon = 'icons/obj/toy.dmi'
	icon_state = "spbox"
	can_hold = list(/obj/item/toy/junk/snappop)
	New()
		..()
		for(var/i=1; i <= 8; i++)
			new /obj/item/toy/junk/snappop(src)

/obj/item/weapon/storage/box/matches
	name = "matchbox"
	desc = "A small box of 'Space-Proof' premium matches."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "matchbox"
	item_state = "zippo"
	w_class = ITEM_SIZE_TINY
	slot_flags = SLOT_BELT
	can_hold = list(/obj/item/weapon/flame/match)

	New()
		..()
		for(var/i=1; i <= 10; i++)
			new /obj/item/weapon/flame/match(src)

	attackby(obj/item/weapon/flame/match/W as obj, mob/user as mob)
		if(istype(W) && !W.lit && !W.burnt)
			playsound(src, 'sound/items/matchstrike.ogg', 20, 1, 1)
			W.lit = 1
			W.damtype = "burn"
			W.icon_state = "match_lit"
			W.tool_qualities = list(QUALITY_CAUTERIZING = 10)
			START_PROCESSING(SSobj, W)
		W.update_icon()
		return

/obj/item/weapon/storage/box/autoinjectors
	name = "box of injectors"
	desc = "Contains autoinjectors."
	icon_state = "syringe"
	New()
		..()
		for (var/i; i < 7; i++)
			new /obj/item/weapon/reagent_containers/hypospray/autoinjector(src)

/obj/item/weapon/storage/box/lights
	name = "box of replacement bulbs"
	icon = 'icons/obj/storage.dmi'
	icon_state = "light"
	desc = "This box is shaped on the inside so that only light tubes and bulbs fit."
	item_state = "syringe_kit"
	use_to_pickup = 1 // for picking up broken bulbs, not that most people will try

/obj/item/weapon/storage/box/lights/New()
	..()
	make_exact_fit()

/obj/item/weapon/storage/box/lights/bulbs/New()
	for(var/i = 0; i < 21; i++)
		new /obj/item/weapon/light/bulb(src)
	..()

/obj/item/weapon/storage/box/lights/tubes
	name = "box of replacement tubes"
	icon_state = "lighttube"

/obj/item/weapon/storage/box/lights/tubes/New()
	for(var/i = 0; i < 21; i++)
		new /obj/item/weapon/light/tube(src)
	..()

/obj/item/weapon/storage/box/lights/mixed
	name = "box of replacement lights"
	icon_state = "lightmixed"

/obj/item/weapon/storage/box/lights/mixed/New()
	for(var/i = 0; i < 14; i++)
		new /obj/item/weapon/light/tube(src)
	for(var/i = 0; i < 7; i++)
		new /obj/item/weapon/light/bulb(src)
	..()

/obj/item/weapon/storage/box/freezer
	name = "portable freezer"
	desc = "This nifty shock-resistant device will keep your 'groceries' nice and non-spoiled."
	icon = 'icons/obj/storage.dmi'
	icon_state = "portafreezer"
	item_state = "medicalpack"
	foldable = null
	max_w_class = ITEM_SIZE_NORMAL
	can_hold = list(/obj/item/organ, /obj/item/weapon/reagent_containers/food, /obj/item/weapon/reagent_containers/glass)
	max_storage_space = 21
	use_to_pickup = 1 // for picking up broken bulbs, not that most people will try

/obj/item/weapon/storage/box/autolathe_blank
	name = "data disk box"
	icon_state = "disk_kit"

/obj/item/weapon/storage/box/autolathe_blank/Initialize()
	. = ..()
	for(var/i in 1 to 7)
		new /obj/item/weapon/computer_hardware/hard_drive/portable(src)