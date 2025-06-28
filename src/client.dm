client
	tick_lag = 0.01
	control_freak = CONTROL_FREAK_SKIN | CONTROL_FREAK_MACROS

	var/role = ROLE_UNDERSTUDY
	var/list/key_presses
	var/key_flags = 0
	var/alist/menus
	var/list/open_menus

	New()
		src.key_presses = list()
		src.menus = alist()
		src.open_menus = list()
		::clients += src

		if (src.IsByondMember())
			world << "BYOND Member [src.key] has joined the world!"

		else
			world << "[src.key] has joined the world."

		if (src.ckey in ::directors)
			src.role = ROLE_DIRECTOR

		..()

	Del()
		::clients -= src
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

			if ("I")
				src.Inventory()

			if ("E")
				src.Interact()

			if ("Escape")
				for (var/ident in src.open_menus)
					src.HideMenu(ident)

	proc/Role() as text
		return ::roles[src.role]

	proc/Interact()
		for (var/atom/movable/m in get_step(src.mob, src.mob.dir))
			m.OnInteract(src.mob)

	proc/Debug()
		var/ident = "debug"

		if (!(ident in src.open_menus))
			src.ShowMenu(ident)

			var/obj/menu/m = src.GetMenu(ident)
			var/t

			m?.Get("title")?.Update("Debug")

			spawn ()
				while (ident in src.open_menus)
					t = "DM v[DM_VERSION].[DM_BUILD]\nCG v[::version]\n[src.mob.name]\n[src.IsByondMember() ? "BYOND Member" : "Non-Member"]\n[src.Role()]\n[src.mob.x], [src.mob.y], [src.mob.z]\n[src.key_presses?.Join(", ")]\nKey Modifiers [src.key_flags]\n"
					m?.Get("textbox")?.Update(t)
					sleep (world.tick_lag)

		else
			src.HideMenu(ident)

	proc/Inventory()

	proc/GetMenu(ident) as /obj/menu
		return src.menus?[ident]

	proc/SetMenu(ident, obj/menu/menu)
		if (istype(menu))
			src.menus?[ident] = menu

	proc/ShowMenu(ident)
		src.GetMenu(ident)?.Show()
		src.open_menus += ident

	proc/HideMenu(ident)
		src.GetMenu(ident)?.Hide()
		src.open_menus -= ident

	verb/KeyDown(k as text)
		set instant = TRUE
		set hidden = TRUE

		src.key_presses ||= list()
		src.key_presses[k] = TRUE

		if (k == "Ctrl")
			src.key_flags |= KEY_CTRL

		if (k == "Alt")
			src.key_flags |= KEY_ALT

		if (k == "Shift")
			src.key_flags |= KEY_SHIFT

		src.Process(k)

	verb/KeyUp(k as text)
		set instant = TRUE
		set hidden = TRUE

		src.key_presses -= k

		if (k == "Ctrl")
			src.key_flags &= ~KEY_CTRL

		if (k == "Alt")
			src.key_flags &= ~KEY_ALT

		if (k == "Shift")
			src.key_flags &= ~KEY_SHIFT
