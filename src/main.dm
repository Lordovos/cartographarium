var/version/version

world
	name = "Cartographarium"
	icon_size = 16
	view = "27x19"
	tick_lag = 0.25
	map_format = SIDE_MAP
	movement_mode = TILE_MOVEMENT_MODE
	mob = /mob/character

	New()
		::version = new ()

obj/crate
	icon = 'assets/tileset.dmi'
	icon_state = "crate"
	density = TRUE

	Click()
		var/vector/v = vector(src.x, src.y)

		world << v
