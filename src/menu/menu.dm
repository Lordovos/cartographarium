obj/menu
	icon = 'assets/menu.dmi'
	plane = 2

	var/ident
	var/client/owner
	var/width = 1
	var/height = 1
	var/list/slices
	var/list/components

	New(loc, ident, client/owner, obj/menu/group/group, vector/size = vector(src.width, src.height), vector/position = vector(1, 1), vector/offset = vector(0, 0))
		src.ident = ident
		src.owner = astype(owner)
		astype(group)?.Set(src.ident, src)
		src.width = size.x
		src.height = size.y
		src.slices = list()
		src.components = list()
		src.Draw(position, offset)

	proc/Draw(vector/position, vector/offset)
		var/width = src.width * SLICE_SIZE
		var/height = src.height * SLICE_SIZE
		var/scale_x = src.width - 1
		var/scale_y = src.height - 1
		var/obj/menu/slice/bl = new (src, "corner")
		var/obj/menu/slice/br = new (src, "corner")
		var/obj/menu/slice/tl = new (src, "corner")
		var/obj/menu/slice/tr = new (src, "corner")

		bl.transform = matrix().Translate(0, 0)
		br.transform = matrix().Turn(270).Translate(width, 0)
		tl.transform = matrix().Turn(90).Translate(0, height)
		tr.transform = matrix().Turn(180).Translate(width, height)
		src.slices += list(bl, br, tl, tr)

		if (src.width > 1)
			var/obj/menu/slice/b = new (src, "side")
			var/obj/menu/slice/t = new (src, "side")

			b.transform = matrix().Scale(scale_x, 1).Translate(width / 2, 0)
			t.transform = matrix().Turn(180).Scale(scale_x, 1).Translate(width / 2, height)
			src.slices += list(b, t)

		if (src.height > 1)
			var/obj/menu/slice/l = new (src, "side")
			var/obj/menu/slice/r = new (src, "side")

			l.transform = matrix().Turn(90).Scale(1, scale_y).Translate(0, height / 2)
			r.transform = matrix().Turn(270).Scale(1, scale_y).Translate(width, height / 2)
			src.slices += list(l, r)

		if (src.width > 1 && src.height > 1)
			var/obj/menu/slice/c = new (src, "center")

			c.transform = matrix().Scale(scale_x, scale_y).Translate(width / 2, height / 2)
			src.slices += c

		src.screen_loc = "[position.x]:[offset.x],[position.y]:[offset.y]"
		src.vis_contents += src.slices

	proc/GetComponent(ident)
		return src.components?[ident]

	proc/SetComponent(ident, component)
		src.components?[ident] = component
