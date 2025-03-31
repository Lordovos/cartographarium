obj/item
	icon = 'assets/items.dmi'
	vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID

	var/rarity = RARITY_COMMON in list(RARITY_COMMON, RARITY_UNCOMMON, RARITY_RARE, RARITY_EPIC, RARITY_LEGENDARY, RARITY_MYTHIC)
	var/quantity = 1 as num

	OnInteract(mob/m)
		m << "\icon[src][src.name] is \an [lowertext(src.Rarity())] item."

	proc/Rarity()
		return ::rarities[src.rarity]

obj/item/fish_hook
	name = "Fish Hook"
	icon_state = "fishhook"

obj/item/mushroom
	name = "Mushroom"
	icon_state = "mushroom"
	rarity = RARITY_UNCOMMON
