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

obj/menu/button/checkbox
	icon_state = "checkbox"

	var/is_checked = FALSE

	proc/Set(boolean)
		src.is_checked = boolean
		src.icon_state = src.is_checked ? "checkboxchecked" : "checkbox"

	Click()
		src.Set(!src.is_checked)

		if (islist(src.target))
			var/mob/character/c = astype(src.target["object"])
			var/v = src.target["var"]

			if (::hasvar(c, v))
				c?.vars[v] = src.is_checked ? src.target["checked"] : src.target["unchecked"]

	MouseEntered()
		src.color = "#f8d890"

	MouseExited()
		src.color = null
