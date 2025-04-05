obj/menu/close
	parent_type = /obj/menu/component
	icon_state = "close"
	mouse_opacity = 2
	vis_flags = VIS_INHERIT_ICON | VIS_INHERIT_PLANE

	var/menu_ident

	New(loc, ident, obj/menu/parent, menu_ident, vector/position = vector(0, 0), vector/offset = vector(0, 0))
		src.ident = ident
		src.parent = astype(parent)
		src.parent?.SetComponent(src.ident, src)
		src.menu_ident = menu_ident
		src.Draw(position, offset)

	Draw(vector/position, vector/offset)
		src.pixel_x = (position.x * SLICE_SIZE) + offset.x
		src.pixel_y = (position.y * SLICE_SIZE) + offset.y
		src.parent?.vis_contents += src

	Click()
		src.parent?.owner?.HideMenu(src.menu_ident)

	MouseEntered()
		src.color = "#fc7460"

	MouseExited()
		src.color = null
