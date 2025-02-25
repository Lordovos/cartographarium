var/regex/maptext_image = regex(@"\{(\w+)}", "g")
var/version/version
var/list/rarities = list("Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic")
var/list/roles = list("Understudy", "Actor", "Director", "Producer")

// This procedure exists purely to include additional resources in the resource file, such as fonts and style sheets.
proc/additional_resources()
	return list(
		/*
			Public Pixel and Vaticanus fonts by GGBotNet (https://www.ggbot.net/)
			Licensed under CC0 1.0 (https://creativecommons.org/publicdomain/zero/1.0/)
		*/
		'assets/fonts/PublicPixel.ttf',
		'assets/fonts/Vaticanus.ttf',
		/*
			map.css and chat.css are hard copies of the style sheets used by the map and chat interface elements, respectively.
			TODO: Automate updating the interface elements with their respective style sheets. Right now you need to manually
			copy and paste the contents of the style sheet into the interface element's style parameter in the
			interface editor.
		*/
		'assets/map.css',
		// 'assets/chat.css'
	)

proc/hasvar(datum/d, v)
	return (v in d?.vars)

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
		src.status = "v[::version]"

	Tick()
		for (var/client/c)
			try
				c.Tick()

			catch ()
