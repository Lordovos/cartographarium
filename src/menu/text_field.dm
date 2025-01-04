obj/menu/text_field
	parent_type = /obj
	layer = 2
	maptext_y = 8
	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_ID

	New(loc, vector/size = vector(src.maptext_width, src.maptext_height))
		..()
		src.maptext_width = size.x
		src.maptext_height = size.y

	proc/Set(maptext)
		src.maptext = maptext
