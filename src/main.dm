var/version/version

world
	name = "Cartographarium"
	icon_size = 16
	view = "27x19"
	fps = 30

	New()
		::version = new ()

mob
	icon = 'assets/characters.dmi'
	icon_state = "base"
	pixel_y = 4

	Login()
		..()
		world << "Welcome to Cartographarium v[::version]!"
		world << "Last compiled with v[DM_VERSION].[DM_BUILD]."
#ifdef DEBUG
		world << "World in debug mode."
#else
		world << "World in release mode."
#endif

turf
	icon = 'assets/tileset.dmi'
	icon_state = "grass"
