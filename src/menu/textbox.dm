obj/menu/textbox
	parent_type = /obj/menu/component
	maptext_y = 8
	vis_flags = VIS_INHERIT_ICON | VIS_INHERIT_PLANE | VIS_INHERIT_ID

	New(loc, ident, obj/menu/parent, vector/size = vector(src.maptext_width, src.maptext_height))
		src.ident = ident
		src.parent = astype(parent)
		src.parent?.SetComponent(src.ident, src)
		src.maptext_width = size.x
		src.maptext_height = size.y
		src.Draw()

	Draw()
		src.parent?.vis_contents += src

	Update(maptext)
		src.maptext = ::maptext_image.Replace(maptext, "<img src=\"assets/menu.dmi\" iconstate=\"$1\" width=\"8\" height=\"8\">")
