mob/character
	icon = 'assets/characters.dmi'
	icon_state = "base"
	pixel_y = 4

	Login()
		..()
		var/obj/waypoint/start/start = locate()

		if (start)
			src.loc = start.loc

	verb/Say(t as text)
		if (t)
			world << "\icon[src][src.name] says: [t]"

	verb/SetStepDelay(n as num)
		if (n)
			src.step_delay = n

	verb/Rock()
		animate(src, transform = turn(src.transform, 25), time = 10, loop = -1, easing = ELASTIC_EASING)
		animate(transform = turn(src.transform, -55), time = 10, easing = ELASTIC_EASING)
