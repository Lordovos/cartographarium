obj/item
	icon = 'assets/items.dmi'
	vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID

	var/static/alist/rarities = alist(
		RARITY_COMMON = null,
		RARITY_UNCOMMON = "air-green",
		RARITY_RARE = "water-blue",
		RARITY_EPIC = "earth-yellow",
		RARITY_LEGENDARY = "fire-red",
		RARITY_MYTHIC = "chaos-purple"
	)
	var/rarity = RARITY_COMMON in list(RARITY_COMMON, RARITY_UNCOMMON, RARITY_RARE, RARITY_EPIC, RARITY_LEGENDARY, RARITY_MYTHIC)
	var/can_stack = FALSE in list(TRUE, FALSE)
	var/quantity = 1 as num

	New(loc, quantity = src.quantity)
		src.quantity = quantity

obj/item/fish_hook
	name = "Fish Hook"
	desc = "A basic metal fish hook."
	icon_state = "fishhook"

obj/item/mushroom
	name = "Mushroom"
	desc = "A mushroom with a red and white cap."
	icon_state = "mushroom"
	rarity = RARITY_UNCOMMON
