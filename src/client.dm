client
	tick_lag = 0.01
	control_freak = CONTROL_FREAK_SKIN

	var/alist/menus

	New()
		src.menus = alist()

		if (src.IsByondMember())
			world << "BYOND Member [src.key] has joined the world!"

		else
			world << "[src.key] has joined the world."

		..()

	Del()
		world << "[src.key] has left the world."
		..()

	Move(loc, dir)
		walk(src.mob, 0)
		return src.mob.Step(dir)

	proc/GetMenu(ident)
		return src.menus?[ident]

	proc/SetMenu(ident, group)
		src.menus?[ident] = group

	proc/ShowMenu(ident)
		src.GetMenu(ident)?.Show(src)

	proc/HideMenu(ident)
		src.GetMenu(ident)?.Hide(src)
