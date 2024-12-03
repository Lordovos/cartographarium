obj/menu/slice
	parent_type = /obj
	icon = 'assets/menu.dmi'
	layer = 1
	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_ID

	New(loc, icon_state)
		..()
		src.icon_state = icon_state
