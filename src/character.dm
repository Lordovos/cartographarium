mob/character
	icon = 'assets/characters.dmi'
	icon_state = "base"
	pixel_y = 4

	Login()
		..()
		var/obj/waypoint/start/start = locate()

		if (start)
			src.loc = start.loc

		switch (src.client?.role)
			if (/role::UNDERSTUDY)
				src << "A studious understudy. Welcome!"

			if (/role::ACTOR)
				src << "An aspiring actor. Welcome back!"

			if (/role::DIRECTOR)
				src << "A dignified director. Your chair awaits!"

			if (/role::PRODUCER)
				src << "The premier producer. You call all the shots!"

			else
				src << "Unknown role!"

	verb/Say(t as text)
		if (t)
			world << "\icon[src][src.name] says: [t]"
