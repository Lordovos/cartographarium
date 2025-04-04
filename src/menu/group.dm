obj/menu/group
	parent_type = /datum

	var/ident
	var/client/owner
	var/alist/menus

	New(ident, client/owner)
		src.ident = ident
		src.owner = astype(owner)
		src.owner?.SetMenu(src.ident, src)
		src.menus = alist()

	proc/Get(ident)
		return src.menus?[ident]

	proc/Set(ident, menu)
		src.menus?[ident] = menu

	proc/Show()
		for (var/ident in src.menus)
			var/obj/menu/menu = src.Get(ident)

			if (menu)
				src.owner?.screen += menu

	proc/Hide()
		for (var/ident in src.menus)
			var/obj/menu/menu = src.Get(ident)

			if (menu)
				src.owner?.screen -= menu

				for (var/c_ident in menu.components)
					menu.GetComponent(c_ident)?.Clear()
