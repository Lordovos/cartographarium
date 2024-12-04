obj/menu/text_field
	parent_type = /obj
	layer = 2
	maptext_y = 8
	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_ID

	New(loc, maptext_width, maptext_height)
		..()
		src.maptext_width = maptext_width
		src.maptext_height = maptext_height

	proc/Set(maptext)
		src.maptext = maptext
