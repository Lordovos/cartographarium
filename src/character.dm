mob/character
	icon = 'assets/characters.dmi'
	icon_state = "base"
	pixel_y = 4

	Login()
		..()

		var/obj/waypoint/start/start = locate()

		if (start)
			src.loc = start.loc

		world << "Welcome to Cartographarium v[::version]!"
		world << "Last compiled with v[DM_VERSION].[DM_BUILD]."
#ifdef DEBUG
		world << "World in debug mode."
#else
		world << "World in release mode."
#endif

	verb/Say(t as text)
		if (t)
			world << "\icon[src][src.name] says: [t]"

	verb/SetStepDelay(n as num)
		if (n)
			src.step_delay = n
