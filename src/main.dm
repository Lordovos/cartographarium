var/version/version

// This procedure exists purely to include additional resources in the resource file, such as fonts and style sheets.
proc/additional_resources()
	return list(
		/*
			Public Pixel font by GGBotNet (https://ggbot.itch.io/)
			Licensed under CC0 1.0 (https://creativecommons.org/publicdomain/zero/1.0/)
		*/
		'assets/fonts/PublicPixel.ttf',
		/*
			map.css and chat.css are hard copies of the style sheets used by the map and chat interface elements, respectively.
			TODO: Automate updating the interface elements with their respective style sheets. Right now you need to manually
			copy and paste the contents of the style sheet into the interface element's style parameter in the
			interface editor.
		*/
		'assets/map.css',
		// 'assets/chat.css'
	)

world
	name = "Cartographarium"
	hub = "LordAndrew.Cartographarium"
	icon_size = 16
	view = "27x19"
	tick_lag = 0.25
	map_format = SIDE_MAP
	movement_mode = TILE_MOVEMENT_MODE
	mob = /mob/character

	New()
		::version = new ()

	Tick()
		for (var/client/c)
			try
				c.Tick()

			catch ()

// Enumerated types in idiomatic DM.
role
	var/const/UNDERSTUDY = "Understudy"
	var/const/ACTOR = "Actor"
	var/const/DIRECTOR = "Director"
	var/const/PRODUCER = "Producer"

rarity
	var/const/COMMON = "Common"
	var/const/UNCOMMON = "Uncommon"
	var/const/RARE = "Rare"
	var/const/EPIC = "Epic"
	var/const/LEGENDARY = "Legendary"
	var/const/MYTHIC = "Mythic"

mob/proc/Menu()
	var/obj/menu/header = src.client?.GetMenu("debug")?.Get("header")
	var/obj/menu/body = src.client?.GetMenu("debug")?.Get("body")
	var/t

	if (!("debug" in src.client?.open_menus))
		src.client?.ShowMenu("debug")
		src.icon_state = "thinking"

		spawn ()
			while ("debug" in src.client?.open_menus)
				t = "DM v[DM_VERSION].[DM_BUILD]\nCG v[::version]\n[src.name]\n[src.client.IsByondMember() ? "BYOND Member\n" : null][src.client?.role]\n@[src.x], [src.y], [src.z]\n[src.client?.key_presses.Join(", ")]\n"
				header?.text_field.Set("Debug")
				body?.text_field.Set(t)
				sleep (world.tick_lag)

	else
		src.client?.HideMenu("debug")
		header?.text_field.Set(null)
		body?.text_field.Set(null)
		src.icon_state = "base"
