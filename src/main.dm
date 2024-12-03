var/version/version

// This procedure exists purely to include additional resources in the resource file, such as fonts.
proc/additional_resources()
	return list(
		/*
			Public Pixel font by GGBotNet (https://ggbot.itch.io/)
			Licensed under CC0 1.0 (https://creativecommons.org/publicdomain/zero/1.0/)
		*/
		'assets/fonts/PublicPixel.ttf'
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

role
	var/const/UNDERSTUDY = "Understudy"
	var/const/ACTOR = "Actor"
	var/const/DIRECTOR = "Director"
	var/const/PRODUCER = "Producer"
