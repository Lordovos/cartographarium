obj/item
	icon = 'assets/items.dmi'

	var/rarity = /rarity::COMMON \
		as anything in list(
			/rarity::COMMON,
			/rarity::UNCOMMON,
			/rarity::RARE,
			/rarity::EPIC,
			/rarity::LEGENDARY,
			/rarity::MYTHIC
		)

	Click()
		usr << "\icon[src][src.name] is \an [lowertext(src.rarity)] item."

obj/item/fish_hook
	name = "Fish Hook"
	icon_state = "fishhook"
