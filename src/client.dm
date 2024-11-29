client
	tick_lag = 0.01

	var/alist/menus

	New()
		src.menus = alist()
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
