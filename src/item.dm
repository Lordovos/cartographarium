obj/item
	icon = 'assets/items.dmi'
	vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID

	var/rarity = RARITY_COMMON in list(RARITY_COMMON, RARITY_UNCOMMON, RARITY_RARE, RARITY_EPIC, RARITY_LEGENDARY, RARITY_MYTHIC)
	var/rarity_color as text
	var/can_stack = FALSE in list(TRUE, FALSE)
	var/quantity = 1 as num

	New(loc, quantity = src.quantity)
		src.rarity_color = list(null, "air-green", "water-blue", "earth-yellow", "fire-red", "chaos-purple")[src.rarity]
		src.quantity = quantity

	proc/Rarity()
		return ::rarities[src.rarity]

obj/item/fish_hook
	name = "Fish Hook"
	desc = "A basic metal fish hook."
	icon_state = "fishhook"

obj/item/mushroom
	name = "Mushroom"
	desc = "A mushroom with a red and white cap."
	icon_state = "mushroom"
	rarity = RARITY_UNCOMMON
