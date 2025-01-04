obj/menu
	plane = 2

	var/ident
	var/list/slices
	var/obj/menu/text_field/text_field

	New(loc, ident, vector/size = vector(1, 1), vector/position = vector(1, 1), vector/offset = vector(0, 0))
		..()
		src.ident = ident
		src.slices = list()
		src.Draw(size, position, offset)

	proc/Draw(vector/size, vector/position, vector/offset)
		var/const/SLICE_SIZE = 8
		var/width = size.x * SLICE_SIZE
		var/height = size.y * SLICE_SIZE
		var/scale_x = (width / SLICE_SIZE) - 1
		var/scale_y = (height / SLICE_SIZE) - 1
		var/obj/menu/slice/bl = new (src, "corner")
		var/obj/menu/slice/br = new (src, "corner")
		var/obj/menu/slice/tl = new (src, "corner")
		var/obj/menu/slice/tr = new (src, "corner")

		bl.transform = matrix().Translate(0, 0)
		br.transform = matrix().Turn(270).Translate(width, 0)
		tl.transform = matrix().Turn(90).Translate(0, height)
		tr.transform = matrix().Turn(180).Translate(width, height)
		src.slices += list(bl, br, tl, tr)

		if (size.x > 1)
			var/obj/menu/slice/b = new (src, "side")
			var/obj/menu/slice/t = new (src, "side")

			b.transform = matrix().Scale(scale_x, 1).Translate(width / 2, 0)
			t.transform = matrix().Turn(180).Scale(scale_x, 1).Translate(width / 2, height)
			src.slices += list(b, t)

		if (size.y > 1)
			var/obj/menu/slice/l = new (src, "side")
			var/obj/menu/slice/r = new (src, "side")

			l.transform = matrix().Turn(90).Scale(1, scale_y).Translate(0, height / 2)
			r.transform = matrix().Turn(270).Scale(1, scale_y).Translate(width, height / 2)
			src.slices += list(l, r)

		if (size.x > 1 && size.y > 1)
			var/obj/menu/slice/c = new (src, "center")

			c.transform = matrix().Scale(scale_x, scale_y).Translate(width / 2, height / 2)
			src.slices += c

		src.screen_loc = "[position.x]:[offset.x],[position.y]:[offset.y]"
		src.text_field = new (src, vector(width + SLICE_SIZE, height - SLICE_SIZE))
		src.vis_contents += list(src.slices, src.text_field)
