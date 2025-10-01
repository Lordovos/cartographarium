mob/character
	icon = 'assets/characters.dmi'
	icon_state = "base"
	pixel_y = 4

	var/tmp/image/nameplate
	var/show_nameplate = TRUE in list(TRUE, FALSE)

	New()
		src.Nameplate()

	Login()
		world << "[src.key] has joined the world."
		src.client.Zoom(src.client.zoom)

		var/obj/waypoint/w = locate("start")

		if (w?.active)
			src.loc = w.loc

		var/obj/menu/d = new (null, "debug", src.client, size = vector(19, 37))

		new /obj/menu/background(null, "background", d, size = vector(d.width, d.height))
		new /obj/menu/close(null, "close", d, vector(d.width - 1, d.height - 1))
		new /obj/menu/textbox(null, "title", d, vector(1, d.height - 1), size = vector((d.width - 3) * SLICE_SIZE, SLICE_SIZE))
		new /obj/menu/separator(null, "separator", d, vector(1, d.height - 2), size = vector(d.width - 1, 1))
		new /obj/menu/textbox(null, "textbox", d, vector(1, 1), size = vector((d.width - 1) * SLICE_SIZE, (d.height - 3) * SLICE_SIZE))
		src.Nameplate()

	Logout()
		world << "[src.key] has left the world."

	MouseEntered()
		if (src.show_nameplate)
			usr.client.images += src.nameplate

	MouseExited()
		usr.client.images -= src.nameplate

	proc/Nameplate()
		if (!src.nameplate)
			src.nameplate = image(loc = src, layer = src.layer + 1, pixel_y = world.icon_size)
			src.nameplate.maptext_width = world.icon_size * 8
			src.nameplate.maptext_x = -(src.nameplate.maptext_width / 2) + (world.icon_size / 2)

		src.nameplate.maptext = "<span class=\"nameplate\">[src.name]</span>"

	verb/Say(t as text)
		if (t)
			world << "<span style=\"color: #d35938\">\icon[src][src.name] says: [t]</span>"
