obj/menu/background
	parent_type = /obj/menu/component
	vis_flags = VIS_INHERIT_ICON | VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID | VIS_UNDERLAY

	var/width = 1
	var/height = 1
	var/list/slices

	New(loc, ident, obj/menu/parent, vector/position = vector(0, 0), vector/offset = vector(0, 0), vector/size = vector(src.width, src.height))
		src.ident = ident
		src.parent = astype(parent)
		src.parent?.Set(src.ident, src)
		src.width = size.x
		src.height = size.y
		src.slices = list()
		src.Draw(position, offset)

	Draw(vector/position, vector/offset)
		var/width = src.width * SLICE_SIZE
		var/height = src.height * SLICE_SIZE
		var/scale_x = src.width - 1
		var/scale_y = src.height - 1
		var/obj/menu/background/slice/bl = new (src, "corner")
		var/obj/menu/background/slice/br = new (src, "corner")
		var/obj/menu/background/slice/tl = new (src, "corner")
		var/obj/menu/background/slice/tr = new (src, "corner")

		bl.transform = matrix().Translate(0, 0)
		br.transform = matrix().Turn(270).Translate(width, 0)
		tl.transform = matrix().Turn(90).Translate(0, height)
		tr.transform = matrix().Turn(180).Translate(width, height)
		src.slices += list(bl, br, tl, tr)

		if (src.width > 1)
			var/obj/menu/background/slice/b = new (src, "side")
			var/obj/menu/background/slice/t = new (src, "side")

			b.transform = matrix().Scale(scale_x, 1).Translate(width / 2, 0)
			t.transform = matrix().Turn(180).Scale(scale_x, 1).Translate(width / 2, height)
			src.slices += list(b, t)

		if (src.height > 1)
			var/obj/menu/background/slice/l = new (src, "side")
			var/obj/menu/background/slice/r = new (src, "side")

			l.transform = matrix().Turn(90).Scale(1, scale_y).Translate(0, height / 2)
			r.transform = matrix().Turn(270).Scale(1, scale_y).Translate(width, height / 2)
			src.slices += list(l, r)

		if (src.width > 1 && src.height > 1)
			var/obj/menu/background/slice/c = new (src, "center")

			c.transform = matrix().Scale(scale_x, scale_y).Translate(width / 2, height / 2)
			src.slices += c

		src.pixel_w = (position.x * SLICE_SIZE) + offset.x
		src.pixel_z = (position.y * SLICE_SIZE) + offset.y
		src.vis_contents += src.slices
		src.parent?.vis_contents += src

obj/menu/background/slice
	parent_type = /atom/movable
	appearance_flags = TILE_BOUND
	vis_flags = VIS_INHERIT_ICON | VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID

	New(loc, icon_state)
		src.icon_state = icon_state
