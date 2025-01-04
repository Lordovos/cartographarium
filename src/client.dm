client
	tick_lag = 0.01
	control_freak = CONTROL_FREAK_SKIN

	var/role = /role::DIRECTOR
	var/list/key_presses
	var/alist/menus
	var/list/open_menus

	New()
		src.key_presses = list()
		src.menus = alist()
		src.open_menus = list()

		if (src.IsByondMember())
			world << "BYOND Member [src.key] has joined the world!"

		else
			world << "[src.key] has joined the world."

		..()

	Del()
		world << "[src.key] has left the world."
		..()

	North()
	South()
	East()
	West()
	Northeast()
	Northwest()
	Southeast()
	Southwest()
	Center()

	proc/Tick()
		set waitfor = FALSE

		var/move_dir = 0

		if (src.key_presses["W"] || src.key_presses["North"])
			move_dir |= NORTH

		if (src.key_presses["A"] || src.key_presses["West"])
			move_dir |= WEST

		if (src.key_presses["S"] || src.key_presses["South"])
			move_dir |= SOUTH

		if (src.key_presses["D"] || src.key_presses["East"])
			move_dir |= EAST

		if (move_dir)
			src.mob.Step(move_dir)

	proc/Process(key)
		switch (key)
			if ("Q")
				src.Debug()

			if ("E")
				src.Interact()

			if ("Escape")
				for (var/ident in src.open_menus)
					src.HideMenu(ident)

	proc/Interact()
		for (var/atom/movable/m in get_step(src.mob, src.mob.dir))
			m.OnInteract(src.mob)

	proc/Debug()
		var/ident = "debug"
		var/obj/menu/header = src.GetMenu(ident)?.Get("header")
		var/obj/menu/body = src.GetMenu(ident)?.Get("body")
		var/maptext

		if (!(ident in src.open_menus))
			src.ShowMenu(ident)

			spawn ()
				while (ident in src.open_menus)
					maptext = "{star}{heart}\nDM v[DM_VERSION].[DM_BUILD]\nCG v[::version]\n[src.mob.name]\n[src.IsByondMember() ? "BYOND Member\n" : null][src.role]\n[src.mob.x], [src.mob.y], [src.mob.z]\n[src.key_presses?.Join(", ")]\n"
					header?.text_field.Set("Debug")
					body?.text_field.Set(maptext)
					sleep (world.tick_lag)

		else
			src.HideMenu(ident)

	proc/GetMenu(ident)
		return src.menus?[ident]

	proc/SetMenu(ident, group)
		src.menus?[ident] = group

	proc/ShowMenu(ident)
		src.GetMenu(ident)?.Show(src)
		src.open_menus += ident

	proc/HideMenu(ident)
		src.GetMenu(ident)?.Hide(src)
		src.open_menus -= ident

	verb/KeyDown(k as text)
		set instant = TRUE
		set hidden = TRUE

		src.key_presses[k] = TRUE
		src.Process(k)

	verb/KeyUp(k as text)
		set instant = TRUE
		set hidden = TRUE

		src.key_presses -= k
