obj/item
	icon = 'assets/items.dmi'

	var/rarity = RARITY_COMMON in list(RARITY_COMMON, RARITY_UNCOMMON, RARITY_RARE, RARITY_EPIC, RARITY_LEGENDARY, RARITY_MYTHIC)

	OnInteract(mob/m)
		m << "\icon[src][src.name] is \an [lowertext(src.Rarity())] item."

	proc/Rarity()
		return ::rarities[src.rarity]

obj/item/fish_hook
	name = "Fish Hook"
	icon_state = "fishhook"
