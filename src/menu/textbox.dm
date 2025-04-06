obj/menu/textbox
	parent_type = /obj/menu/component
	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_ID

	New(loc, ident, obj/menu/parent, vector/size = vector(src.maptext_width, src.maptext_height), vector/position = vector(0, 0), vector/offset = vector(0, 0))
		src.ident = ident
		src.parent = astype(parent)
		src.parent?.SetComponent(src.ident, src)
		src.maptext_width = size.x
		src.maptext_height = size.y
		src.Draw(position, offset)

	Draw(vector/position, vector/offset)
		src.pixel_x = (position.x * SLICE_SIZE) + offset.x
		src.pixel_y = (position.y * SLICE_SIZE) + offset.y
		src.parent?.vis_contents += src

	Update(maptext)
		src.maptext = istext(maptext) ? "<span class=\"menu\">[::maptext_image.Replace(maptext, "<img src=\"assets/menu.dmi\" iconstate=\"$1\" width=\"8\" height=\"8\">")]</span>" : null

	Clear()
		src.maptext = null
