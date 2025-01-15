mob/character
	icon = 'assets/characters.dmi'
	icon_state = "base"
	pixel_y = 4

	Login()
		..()
		var/obj/waypoint/start/start = locate()

		if (start)
			src.loc = start.loc

		var/obj/menu/group/g = new ("debug", src.client)
		var/obj/menu/header = new (null, "header", src.client, g, vector(19, 2), vector(1, 18), vector(0, 8))
		var/obj/menu/body = new (null, "body", src.client, g, vector(19, 34))
		new /obj/menu/button/close(null, "close", header, g.ident, vector(18, 1))
		new /obj/menu/button/checkbox(null, "checkbox", body, list("object" = src, "var" = "density", "checked" = TRUE, "unchecked" = FALSE), vector(1, 26)).Set(TRUE)

	verb/Say(t as text)
		if (t)
			world << "<span style=\"color: #d35938\">\icon[src][src.name] says: [t]</span>"
