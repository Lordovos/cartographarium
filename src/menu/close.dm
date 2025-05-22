obj/menu/close
	parent_type = /obj/menu/component
	icon_state = "close"
	mouse_opacity = 2
	vis_flags = VIS_INHERIT_ICON | VIS_INHERIT_LAYER | VIS_INHERIT_PLANE

	New(loc, ident, obj/menu/parent, vector/position = vector(0, 0), vector/offset = vector(0, 0))
		src.ident = ident
		src.parent = astype(parent)
		src.parent?.Set(src.ident, src)
		src.Draw(position, offset)

	Draw(vector/position, vector/offset)
		src.pixel_w = (position.x * SLICE_SIZE) + offset.x
		src.pixel_z = (position.y * SLICE_SIZE) + offset.y
		src.parent?.vis_contents += src

	Click()
		src.parent?.owner?.HideMenu(src.parent?.ident)

	MouseEntered()
		src.color = "#fc7460"

	MouseExited()
		src.color = null
