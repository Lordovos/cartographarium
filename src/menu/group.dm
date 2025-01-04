obj/menu/group
	parent_type = /datum

	var/ident
	var/alist/menus

	New(ident)
		src.ident = ident
		src.menus = alist()

	proc/Get(ident)
		return src.menus?[ident]

	proc/Set(ident, menu)
		src.menus?[ident] = menu

	proc/Show(client/c)
		for (var/ident in src.menus)
			var/obj/menu/menu = src.Get(ident)

			if (menu)
				c.screen += menu

	proc/Hide(client/c)
		for (var/ident in src.menus)
			var/obj/menu/menu = src.Get(ident)

			if (menu)
				c.screen -= menu
				menu.text_field?.Set(null)
