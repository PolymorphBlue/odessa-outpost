/obj/item/clothing/under/rank/mercenary
	name = "green tactical turtleneck"
	desc = "Military style turtleneck, for operating in cold environments. Typically worn underneath armour"
	icon_state = "greenturtle"
	item_state = "bl_suit"
	has_sensor = 0
	siemens_coefficient = 0.9
	price_tag = 50


/obj/item/clothing/under/rank/mercenary/New()
	if (prob(50))
		name = "black tactical turtleneck"
		icon_state = "blackturtle"
