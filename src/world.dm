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
		src.log = file("logs/world.log")

		var/list/config = ::load_config()

		::version = new ()
		src.status = "v[::version]"
		::clients = list()
		::staff = config["staff"] || alist()
		::cursors = ::generate_cursors()

	Del()
		::save_config()

	Error(exception)
		src.log << ::error(exception)

	Tick()
		for (var/client/c in ::clients)
			try
				c.Tick()

			catch ()
