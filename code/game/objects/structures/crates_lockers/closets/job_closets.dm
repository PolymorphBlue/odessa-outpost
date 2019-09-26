/* Closets for specific jobs
 * Contains:
 *		Bartender
 *		Janitor
 *		Lawyer
 *		Acolyte
 */

/*
 * Bartender
 */
/obj/structure/closet/gmcloset
	name = "formal closet"
	desc = "It's a storage unit for formal clothing."
	icon_door = "black"

/obj/structure/closet/gmcloset/populate_contents()
	new /obj/item/clothing/head/tophat(src)
	new /obj/item/clothing/head/tophat(src)
	new /obj/item/device/radio/headset/headset_service(src)
	new /obj/item/device/radio/headset/headset_service(src)
	new /obj/item/clothing/head/hairflower
	new /obj/item/clothing/under/rank/bartender(src)
	new /obj/item/clothing/under/rank/bartender(src)
	new /obj/item/clothing/suit/wcoat(src)
	new /obj/item/clothing/suit/wcoat(src)
	new /obj/item/clothing/shoes/color/black(src)
	new /obj/item/clothing/shoes/color/black(src)

/*
 * Chef
 */
/obj/structure/closet/chefcloset
	name = "chef's closet"
	desc = "It's a storage unit for foodservice garments."
	icon_door = "black"

/obj/structure/closet/chefcloset/populate_contents()
	new /obj/item/clothing/under/costume/job/waiter(src)
	new /obj/item/clothing/under/costume/job/waiter(src)
	new /obj/item/device/radio/headset/headset_service(src)
	new /obj/item/device/radio/headset/headset_service(src)
	new /obj/item/weapon/storage/box/mousetraps(src)
	new /obj/item/weapon/storage/box/mousetraps(src)
	new /obj/item/clothing/under/rank/chef(src)
	new /obj/item/clothing/head/rank/chef(src)

/*
 * Janitor
 */
/obj/structure/closet/jcloset
	name = "custodial closet"
	desc = "It's a storage unit for janitorial clothes and gear."
	icon_state = "custodian"

/obj/structure/closet/jcloset/populate_contents()
	new /obj/item/clothing/under/rank/church(src)
	new /obj/item/weapon/storage/belt/church(src)
	new /obj/item/device/radio/headset/church(src)
	new /obj/item/clothing/gloves/thick(src)
	new /obj/item/clothing/suit/armor/vest/custodian(src)
	new /obj/item/clothing/head/helmet/custodian(src)
	new /obj/item/clothing/head/soft/purple(src)
	new /obj/item/clothing/head/beret/purple(src)
	new /obj/item/device/lighting/toggleable/flashlight(src)
	new /obj/item/weapon/caution(src)
	new /obj/item/weapon/caution(src)
	new /obj/item/weapon/caution(src)
	new /obj/item/weapon/caution(src)
	new /obj/item/device/lightreplacer(src)
	new /obj/item/weapon/storage/bag/trash(src)
	new /obj/item/clothing/shoes/galoshes(src)
	new /obj/item/weapon/mop(src)
	new /obj/item/weapon/storage/pouch/small_generic/purple(src) // Because I feel like poor janitor gets it bad.
	new /obj/item/weapon/storage/pouch/janitor_supply(src)
	new /obj/item/weapon/storage/pouch/small_generic(src) // Because I feel like poor janitor gets it bad.
	if(prob(50))
		new /obj/item/weapon/storage/backpack/church(src)
	else
		new /obj/item/weapon/storage/backpack/satchel/church(src)

/obj/structure/closet/acolyte
	name = "acolyte closet"
	desc = "A closet for those that work with the machines of god."
	icon_state = "acolyte"

/obj/structure/closet/acolyte/populate_contents()
	new /obj/item/clothing/under/rank/church(src)
	new /obj/item/weapon/storage/belt/church(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/device/radio/headset/church(src)
	new /obj/item/clothing/gloves/thick(src)
	new /obj/item/clothing/suit/armor/vest/acolyte(src)
	new /obj/item/clothing/head/helmet/acolyte(src)
	if(prob(50))
		new /obj/item/weapon/storage/backpack/church(src)
	else
		new /obj/item/weapon/storage/backpack/satchel/church(src)