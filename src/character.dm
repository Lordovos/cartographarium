mob/character
	icon = 'assets/characters.dmi'
	icon_state = "base"
	pixel_y = 4

	var/tmp/image/nameplate
	var/show_nameplate = TRUE in list(TRUE, FALSE)

	New()
		src.Nameplate()

	Login()
		var/obj/waypoint/w = locate("start")

		if (w?.is_active)
			src.loc = w.loc

		var/obj/menu/group/g = new ("debug", src.client)
		var/obj/menu/header = new (null, "header", src.client, g, vector(19, 2), vector(1, 18), vector(0, 8))
		var/obj/menu/body = new (null, "body", src.client, g, vector(19, 34))

		new /obj/menu/button/close(null, "close", header, g.ident, vector(18, 1))
		new /obj/menu/textbox(null, "textbox", header, vector(18 * SLICE_SIZE, 1 * SLICE_SIZE), vector(1, 1))
		new /obj/menu/textbox(null, "textbox", body, vector(18 * SLICE_SIZE, 33 * SLICE_SIZE), vector(1, 1))
		// TODO: Address that clients can change mobs, so we'll need to update checkbox.target["object"] for all checkboxes upon switching mobs.
		new /obj/menu/button/checkbox(null, "checkbox_density", body, list("object" = src, "var" = "density", "checked" = TRUE, "unchecked" = FALSE), vector(11, 26)).Update(src.density)
		new /obj/menu/button/checkbox(null, "checkbox_show_nameplate", body, list("object" = src, "var" = "show_nameplate", "checked" = TRUE, "unchecked" = FALSE), vector(11, 25)).Update(src.show_nameplate)
		src.Nameplate()

	MouseEntered()
		if (src.show_nameplate)
			usr.client.images += src.nameplate

	MouseExited()
		usr.client.images -= src.nameplate

	proc/Nameplate()
		if (!src.nameplate)
			src.nameplate = image(loc = src, layer = src.layer + 1, pixel_y = world.icon_size)
			src.nameplate.maptext_width = 128
			src.nameplate.maptext_x = -(src.nameplate.maptext_width / 2) + (world.icon_size / 2)

		src.nameplate.maptext = "<span class=\"nameplate\">[src.name]</span>"

	verb/Say(t as text)
		if (t)
			world << "<span style=\"color: #d35938\">\icon[src][src.name] says: [t]</span>"
