var/version/version

// This procedure exists purely to include additional resources in the resource file, such as fonts.
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

mob/verb/Menu()
	var/obj/menu/group/g = new ("test")
	var/obj/menu/m = new (null, "test", vector(15, 23))
	var/t = "Hello, world! This is a test.\n\n"
	var/list/classes = list("air-green", "earth-yellow", "fire-red", "water-blue", "dark-gray", "spirit-white", "chaos-purple")

	t += "(default)\n"

	for (var/class in classes)
		t += "<span class=\"[class]\">[class]</span>\n"

	t += "\n&#9608;"

	for (var/class in classes)
		t += "<span class=\"[class]\">&#9608;</span>"

	t += "\n"
	m.text_field.Set(t)
	g.Set(m.ident, m)
	src.client.SetMenu(g.ident, g)
	src.client.ShowMenu(g.ident)
