obj/menu/textbox
	parent_type = /obj/menu/component
	vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID

	New(loc, ident, obj/menu/parent, vector/position = vector(0, 0), vector/offset = vector(0, 0), vector/size = vector(src.maptext_width, src.maptext_height))
		src.ident = ident
		src.parent = astype(parent)
		src.parent?.Set(src.ident, src)
		src.maptext_width = size.x
		src.maptext_height = size.y
		src.Draw(position, offset)

	Draw(vector/position, vector/offset)
		src.pixel_w = (position.x * SLICE_SIZE) + offset.x
		src.pixel_z = (position.y * SLICE_SIZE) + offset.y
		src.parent?.vis_contents += src

	Update(maptext)
		src.maptext = istext(maptext) ? "<span class=\"menu\">[::maptext_image.Replace(maptext, "<img src=\"assets/menu.dmi\" iconstate=\"$1\" width=\"8\" height=\"8\">")]</span>" : null

	Clear()
		src.maptext = null
