obj/menu/button
	parent_type = /obj
	layer = 2
	mouse_opacity = 2
	vis_flags = VIS_INHERIT_ICON | VIS_INHERIT_PLANE

	var/ident
	var/obj/menu/parent
	var/target

	New(loc, ident, obj/menu/parent, target, vector/position = vector(0, 0), vector/offset = vector(0, 0))
		..()
		src.ident = ident
		src.parent = astype(parent)
		src.parent?.SetComponent(src.ident, src)
		src.target = target
		src.Draw(position, offset)

	proc/Draw(vector/position, vector/offset)
		var/const/SLICE_SIZE = 8

		src.pixel_x = (position.x * SLICE_SIZE) + offset.x
		src.pixel_y = (position.y * SLICE_SIZE) + offset.y
		src.parent?.vis_contents += src

obj/menu/button/close
	icon_state = "close"

	Click()
		if (istext(src.target))
			src.parent?.owner?.HideMenu(src.target)

	MouseEntered()
		src.color = "#fc7460"

	MouseExited()
		src.color = null
