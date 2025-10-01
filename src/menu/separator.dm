obj/menu/separator
	parent_type = /obj/menu/component
	icon_state = "middle"
	vis_flags = VIS_INHERIT_ICON | VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID

	var/width = 1
	var/height = 1
	var/vertical = FALSE

	New(loc, ident, obj/menu/parent, vector/size = vector(src.width, src.height), vertical = src.vertical, vector/position = vector(0, 0), vector/offset = vector(0, 0))
		src.ident = ident
		src.parent = astype(parent)
		src.parent?.Set(src.ident, src)
		src.width = size.x
		src.height = size.y
		src.vertical = vertical
		src.Draw(position, offset)

	Draw(vector/position, vector/offset)
		if (src.vertical)
			src.transform = matrix().Turn(90).Scale(1, src.height).Translate(0, ((src.height - 1) * SLICE_SIZE) / 2)

		else
			src.transform = matrix().Scale(src.width, 1).Translate(((src.width - 1) * SLICE_SIZE) / 2, 0)

		src.pixel_w = (position.x * SLICE_SIZE) + offset.x
		src.pixel_z = (position.y * SLICE_SIZE) + offset.y
		src.parent?.vis_contents += src
