client
	tick_lag = 0.01
	control_freak = CONTROL_FREAK_SKIN

	var/role = /role::DIRECTOR
	var/list/keys_pressed
	var/alist/menus

	New()
		src.keys_pressed = list()
		src.menus = alist()

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

		if (src.keys_pressed["W"])
			move_dir |= NORTH

		if (src.keys_pressed["A"])
			move_dir |= WEST

		if (src.keys_pressed["S"])
			move_dir |= SOUTH

		if (src.keys_pressed["D"])
			move_dir |= EAST

		if (move_dir)
			src.mob.Step(move_dir)

	proc/Process()
		if (src.keys_pressed["I"])
			src.mob.Menu()

		if (src.keys_pressed["Ctrl"] && src.keys_pressed["I"])
			src.screen.Cut()

		if (src.keys_pressed["T"])
			world << "Hello, world!"

	proc/GetMenu(ident)
		return src.menus?[ident]

	proc/SetMenu(ident, group)
		src.menus?[ident] = group

	proc/ShowMenu(ident)
		src.GetMenu(ident)?.Show(src)

	proc/HideMenu(ident)
		src.GetMenu(ident)?.Hide(src)

	verb/KeyDown(k as text)
		set instant = TRUE
		set hidden = TRUE

		src.keys_pressed[k] = TRUE
		src.Process()

	verb/KeyUp(k as text)
		set instant = TRUE
		set hidden = TRUE

		src.keys_pressed -= k
