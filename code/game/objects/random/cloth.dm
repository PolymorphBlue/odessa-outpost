//CLOTH RANDOM
/obj/random/cloth/masks
	name = "random mask"
	desc = "This is a random mask."
	icon_state = "armor-grey"

/obj/random/cloth/masks/item_to_spawn()
	return pickweight(list(/obj/item/clothing/mask/balaclava = 15,
				/obj/item/clothing/mask/balaclava/tactical = 20,
				/obj/item/clothing/mask/bandana = 2,
				/obj/item/clothing/mask/bandana/blue = 1,
				/obj/item/clothing/mask/bandana/botany = 1,
				/obj/item/clothing/mask/bandana/camo = 1,
				/obj/item/clothing/mask/bandana/yellow = 1,
				/obj/item/clothing/mask/bandana/green = 1,
				/obj/item/clothing/mask/bandana/orange = 1,
				/obj/item/clothing/mask/bandana/purple = 1,
				/obj/item/clothing/mask/bandana/red = 1,
				/obj/item/clothing/mask/bandana/skull = 1,
				/obj/item/clothing/mask/breath = 20,
				/obj/item/clothing/mask/breath/medical = 5,
				/obj/item/clothing/mask/gas = 20,
				/obj/item/clothing/mask/costume/job/clown = 10,
				/obj/item/clothing/mask/gas/ihs = 10,
				/obj/item/clothing/mask/gas/tactical = 2,
				/obj/item/clothing/mask/gas/voice = 2,
				/obj/item/clothing/mask/costume/job/luchador = 2,
				/obj/item/clothing/mask/costume/job/luchador/rudos = 2,
				/obj/item/clothing/mask/costume/job/luchador/tecnicos = 2,
				/obj/item/clothing/mask/muzzle = 2,
				/obj/item/clothing/mask/scarf = 2,
				/obj/item/clothing/mask/scarf/green = 2,
				/obj/item/clothing/mask/scarf/ninja = 2,
				/obj/item/clothing/mask/scarf/red = 2,
				/obj/item/clothing/mask/scarf/redwhite = 2,
				/obj/item/clothing/mask/scarf/stripedblue = 2,
				/obj/item/clothing/mask/scarf/stripedgreen = 2,
				/obj/item/clothing/mask/scarf/stripedred = 2,
				/obj/item/clothing/mask/surgical = 8))

/obj/random/cloth/masks/low_chance
	name = "low chance random mask"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60





/obj/random/cloth/armor
	name = "random armor"
	desc = "This is a random armor."
	icon_state = "armor-grey"

/obj/random/cloth/armor/item_to_spawn()
	return pickweight(list(/obj/item/clothing/suit/armor/bulletproof = 10,
				/obj/item/clothing/suit/armor/captain = 1,
				/obj/item/clothing/suit/armor/heavy = 2,
				/obj/item/clothing/suit/armor/riot = 4,
				/obj/item/clothing/suit/armor/laserproof = 2,
				/obj/item/clothing/suit/armor/vest/detective  = 10,
				/obj/item/clothing/suit/armor/vest/handmade = 20,
				/obj/item/clothing/suit/space/void/SCAF = 1,
				/obj/item/clothing/suit/armor/vest/security = 20))

/obj/random/cloth/armor/low_chance
	name = "low chance random armor"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60




/obj/random/cloth/suit
	name = "random suit"
	desc = "This is a random suit."
	icon_state = "armor-grey"

/obj/random/cloth/suit/item_to_spawn()
	return pickweight(list(/obj/item/clothing/suit/poncho = 10,
				/obj/item/clothing/suit/storage/rank/ass_jacket = 10,
				/obj/item/clothing/suit/storage/rank/cargo_jacket = 10,
				/obj/item/clothing/suit/storage/rank/det_trench = 5,
				/obj/item/clothing/suit/storage/hazardvest = 10,
				/obj/item/clothing/suit/storage/rank/insp_trench  = 3,
				/obj/item/clothing/suit/storage/leather_jacket = 3,
				/obj/item/clothing/suit/storage/rank/robotech_jacket = 10,
				/obj/item/clothing/suit/storage/toggle/bomber = 5,
				/obj/item/clothing/suit/storage/toggle/hoodie = 5,
				/obj/item/clothing/suit/storage/toggle/hoodie/black = 5,
				/obj/item/clothing/suit/storage/toggle/labcoat = 3,
				/obj/item/clothing/suit/storage/toggle/labcoat/chemist= 3,
				/obj/item/clothing/suit/storage/toggle/labcoat/cmo = 3,
				/obj/item/clothing/suit/storage/toggle/labcoat/medspec = 3,
				/obj/item/clothing/suit/storage/toggle/labcoat/science = 3,
				/obj/item/clothing/suit/storage/toggle/labcoat/virologist = 3,
				/obj/item/clothing/suit/storage/rank/qm_coat = 2))

/obj/random/cloth/suit/low_chance
	name = "low chance random suit"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60





/obj/random/cloth/hazmatsuit
	name = "random hazmat suit"
	desc = "This is a random hazmat suit."
	icon_state = "armor-grey"

/obj/random/cloth/hazmatsuit/item_to_spawn()
	return pickweight(list(/obj/item/clothing/suit/bio_suit = 5,
				/obj/item/clothing/suit/bio_suit/cmo = 5,
				/obj/item/clothing/suit/bio_suit/general = 5,
				/obj/item/clothing/suit/bio_suit/janitor = 5,
				/obj/item/clothing/suit/bio_suit/scientist = 5,
				/obj/item/clothing/suit/bio_suit/security = 5,
				/obj/item/clothing/suit/bio_suit/virology = 5,
				/obj/item/clothing/suit/radiation = 30,
				/obj/item/clothing/suit/bomb_suit = 20))

/obj/random/cloth/hazmatsuit/low_chance
	name = "low chance random hazmat suit"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60





/obj/random/cloth/under
	name = "random under"
	desc = "This is a random under."
	icon_state = "armor-grey"

/obj/random/cloth/under/item_to_spawn()
	return pickweight(list(/obj/item/clothing/under/color/aqua = 5,
				/obj/item/clothing/under/rank/assistant/formal = 5,
				/obj/item/clothing/under/suit_jacket/blackskirt = 5,
				/obj/item/clothing/under/suit_jacket/blazer = 5,
				/obj/item/clothing/under/pj/blue = 5,
				/obj/item/clothing/under/color/brown = 5,
				/obj/item/clothing/under/rank/captain/formal = 2,
				/obj/item/clothing/under/color/yellow = 5,
				/obj/item/clothing/under/color/yellow = 5,
				/obj/item/clothing/under/color/red = 5,
				/obj/item/clothing/under/color/pink = 5,
				/obj/item/clothing/under/orange = 5,
				/obj/item/clothing/under/color/green = 5,
				/obj/item/clothing/under/color = 5,
				/obj/item/clothing/under/color/black = 5,
				/obj/item/clothing/under/color/darkblue = 5,
				/obj/item/clothing/under/color/darkred = 5,
				/obj/item/clothing/under/suit_jacket/brown = 5,
				/obj/item/clothing/under/color/lightblue = 5,
				/obj/item/clothing/under/color/lightbrown = 5,
				/obj/item/clothing/under/color/lightgreen = 5,
				/obj/item/clothing/under/color/lightpurple = 5,
				/obj/item/clothing/under/color/lightred = 5,
				/obj/item/clothing/under/overalls = 5,
				/obj/item/clothing/under/costume/history/pirate = 5,
				/obj/item/clothing/under/color/purple = 5,
				/obj/item/clothing/under/costume/misc/rainbowjumpsuit = 5,
				/obj/item/clothing/under/pj = 5,
				/obj/item/clothing/under/plaid/schoolgirlblue = 5,
				/obj/item/clothing/under/suit_jacket/red = 5,
				/obj/item/clothing/under/suit_jacket = 5,
				/obj/item/clothing/under/turtleneck = 5,
				/obj/item/clothing/under/tactical = 5,
				/obj/item/clothing/under/syndicate = 5))

/obj/random/cloth/under/low_chance
	name = "low chance random under"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60





/obj/random/cloth/helmet
	name = "random helmet"
	desc = "This is a random helmet."
	icon_state = "armor-grey"

/obj/random/cloth/helmet/item_to_spawn()
	return pickweight(list(/obj/item/clothing/head/helmet = 5,
				/obj/item/clothing/head/helmet/riot = 5,
				/obj/item/clothing/head/helmet/swat = 3,
				/obj/item/clothing/head/helmet/space/void/SCAF = 1))

/obj/random/cloth/helmet/low_chance
	name = "low chance random helmet"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60




/obj/random/cloth/head
	name = "random head"
	desc = "This is a random head."
	icon_state = "armor-grey"

/obj/random/cloth/head/item_to_spawn()
	return pickweight(list(/obj/item/clothing/head/costume/animal/kitty = 1,    //God forgive us
				/obj/item/clothing/head/bandana/green = 5,
				/obj/item/clothing/head/beret = 5,
				/obj/item/clothing/head/rank/commander = 1,
				/obj/item/clothing/head/bearpelt = 5,
				/obj/item/clothing/head/bowler = 5,
				/obj/item/clothing/head/bowler/bowlerclassic = 5,
				/obj/item/clothing/head/costume/misc/cake = 5,
				/obj/item/clothing/head/rank/chaplain = 5,
				/obj/item/clothing/head/rank/chef = 5,
				/obj/item/clothing/head/fedora/feathered = 5,
				/obj/item/clothing/head/flatcap = 5,
				/obj/item/clothing/head/fez = 5,
				/obj/item/clothing/head/fedora = 5,
				/obj/item/clothing/head/firefighter/chief = 5,
				/obj/item/clothing/head/hardhat = 5,
				/obj/item/clothing/head/costume/job/nun = 5,
				/obj/item/clothing/head/costume/history/philosopher = 5,
				/obj/item/clothing/head/bandana/orange = 5,
				/obj/item/clothing/head/bandana/green = 5,
				/obj/item/clothing/head/costume/job/nun = 5,
				/obj/item/clothing/head/rank/inspector/grey = 5,
				/obj/item/clothing/head/rank/inspector = 5,
				/obj/item/clothing/head/soft = 1,
				/obj/item/clothing/head/soft/red = 1,
				/obj/item/clothing/head/costume/misc/rainbow = 1,
				/obj/item/clothing/head/soft/purple = 1,
				/obj/item/clothing/head/soft/orange = 1,
				/obj/item/clothing/head/soft/mime = 1,
				/obj/item/clothing/head/soft/grey = 1,
				/obj/item/clothing/head/soft/green = 1,
				/obj/item/clothing/head/soft/blue = 1,
				/obj/item/clothing/head/soft = 5,
				/obj/item/clothing/head/tophat = 5,
				/obj/item/clothing/head/ushanka = 3,
				/obj/item/clothing/head/welding = 5))

/obj/random/cloth/head/low_chance
	name = "low chance random head"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60




/obj/random/cloth/gloves
	name = "random gloves"
	desc = "This is a random gloves."
	icon_state = "armor-grey"

/obj/random/cloth/gloves/item_to_spawn()
	return pickweight(list(/obj/item/clothing/gloves/botanic_leather = 3,
				/obj/item/clothing/gloves/boxing = 2,
				/obj/item/clothing/gloves/boxing/blue = 5,
				/obj/item/clothing/gloves/boxing/green = 1,
				/obj/item/clothing/gloves/boxing/yellow = 1,
				/obj/item/clothing/gloves/captain = 1,
				/obj/item/clothing/gloves/color = 3,
				/obj/item/clothing/gloves/color/blue = 3,
				/obj/item/clothing/gloves/color/brown = 3,
				/obj/item/clothing/gloves/color/green = 3,
				/obj/item/clothing/gloves/color/grey = 3,
				/obj/item/clothing/gloves/color/light_brown = 3,
				/obj/item/clothing/gloves/color/orange = 3,
				/obj/item/clothing/gloves/color/purple = 3,
				/obj/item/clothing/gloves/rainbow = 3,
				/obj/item/clothing/gloves/color/red = 3,
				/obj/item/clothing/gloves/color/yellow = 3,
				/obj/item/clothing/gloves/insulated = 6,
				/obj/item/clothing/gloves/insulated/cheap = 7,
				/obj/item/clothing/gloves/latex = 9,
				/obj/item/clothing/gloves/thick = 5,
				/obj/item/clothing/gloves/thick/combat = 1,
				/obj/item/clothing/gloves/thick/swat = 2,
				/obj/item/clothing/gloves/stungloves = 1))

/obj/random/cloth/gloves/low_chance
	name = "low chance random gloves"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60




/obj/random/cloth/glasses
	name = "random glasses"
	desc = "This is a random glasses."
	icon_state = "armor-grey"

/obj/random/cloth/glasses/item_to_spawn()
	return pickweight(list(/obj/item/clothing/glasses/eyepatch = 4,
				/obj/item/clothing/glasses/regular/gglasses = 2,
				/obj/item/clothing/glasses/hud/health = 2,
				/obj/item/clothing/glasses/hud/security = 2,
				/obj/item/clothing/glasses/sechud/tactical = 2,
				/obj/item/clothing/glasses/threedglasses = 4,
				/obj/item/clothing/glasses/welding = 4))

/obj/random/cloth/glasses/low_chance
	name = "low chance random glasses"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60




/obj/random/cloth/shoes
	name = "random shoes"
	desc = "This is a random shoes"
	icon_state = "armor-grey"

/obj/random/cloth/shoes/item_to_spawn()
	return pickweight(list(/obj/item/clothing/shoes/color/black = 14,
				/obj/item/clothing/shoes/costume/job/clown = 14,
				/obj/item/clothing/shoes/color/blue = 1,   //Those are ugly, so they are rare
				/obj/item/clothing/shoes/color/brown = 1,
				/obj/item/clothing/shoes/color/green = 1,
				/obj/item/clothing/shoes/orange = 1,
				/obj/item/clothing/shoes/color/purple = 1,
				/obj/item/clothing/shoes/costume/misc/rainbow = 1,
				/obj/item/clothing/shoes/color = 1,
				/obj/item/clothing/shoes/color/red = 1,
				/obj/item/clothing/shoes/color/yellow = 1,
				/obj/item/clothing/shoes/combat = 2,  //No slip
				/obj/item/clothing/shoes/galoshes = 8,
				/obj/item/clothing/shoes/jackboots = 14,
				/obj/item/clothing/shoes/leather = 14,
				/obj/item/clothing/shoes/reinforced = 14,
				/obj/item/clothing/shoes/swat = 14,
				/obj/item/clothing/shoes/workboots = 4))

/obj/random/cloth/shoes/low_chance
	name = "low chance random shoes"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60




/obj/random/cloth/backpack
	name = "random backpack"
	desc = "This is a random backpack"
	icon_state = "armor-grey"

/obj/random/cloth/backpack/item_to_spawn()
	return pickweight(list(/obj/item/weapon/storage/backpack = 18,
				/obj/item/weapon/storage/backpack/captain = 1,
				/obj/item/weapon/storage/backpack/clown = 4,
				/obj/item/weapon/storage/backpack/industrial = 6,
				/obj/item/weapon/storage/backpack/medic = 6,
				/obj/item/weapon/storage/backpack/military = 6,
				/obj/item/weapon/storage/backpack/security = 6,
				/obj/item/weapon/storage/backpack/satchel/cap = 1,
				/obj/item/weapon/storage/backpack/satchel/eng = 6,
				/obj/item/weapon/storage/backpack/satchel/med = 6,
				/obj/item/weapon/storage/backpack/satchel/norm = 6,
				/obj/item/weapon/storage/backpack/satchel/sec = 6,
				/obj/item/weapon/storage/backpack/satchel/withwallet = 18))

/obj/random/cloth/backpack/low_chance
	name = "low chance random backpack"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60




/obj/random/cloth/belt
	name = "random belt"
	desc = "This is a random belt"
	icon_state = "armor-grey"

/obj/random/cloth/belt/item_to_spawn()
	return pickweight(list(/obj/item/weapon/storage/belt/medical = 8,
				/obj/item/weapon/storage/belt/medical/emt = 8,
				/obj/item/weapon/storage/belt/security = 4,
				/obj/item/weapon/storage/belt/utility = 8,))

/obj/random/cloth/belt/low_chance
	name = "low chance random belt"
	icon_state = "armor-grey-low"
	spawn_nothing_percentage = 60
