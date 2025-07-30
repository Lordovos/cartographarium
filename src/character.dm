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

		if (w?.is_active)
			src.loc = w.loc

		var/obj/menu/m = new (null, "debug", src.client, vector(19, 37))

		new /obj/menu/background(null, "background", m, vector(m.width, m.height))
		new /obj/menu/close(null, "close", m, vector(m.width - 1, m.height - 1))
		new /obj/menu/textbox(null, "title", m, vector((m.width - 3) * SLICE_SIZE, 1 * SLICE_SIZE), vector(1, m.height - 1))
		new /obj/menu/separator(null, "separator", m, vector(m.width - 1, 1), FALSE, vector(1, m.height - 2))
		new /obj/menu/textbox(null, "textbox", m, vector((m.width - 1) * SLICE_SIZE, (m.height - 3) * SLICE_SIZE), vector(1, 1))
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
