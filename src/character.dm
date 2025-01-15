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
		var/obj/menu/header = new (null, "header", src.client, g, vector(15, 2), vector(1, 13))
		new /obj/menu(null, "body", src.client, g, vector(15, 23))
		new /obj/menu/button/close(null, "close", header, g.ident, vector(14, 1))

		var/obj/menu/group/g2 = new ("inventory", src.client)
		var/obj/menu/header2 = new (null, "header", src.client, g2, vector(15, 2), vector(15, 13))
		new /obj/menu(null, "body", src.client, g2, vector(15, 23), vector(15, 1))
		new /obj/menu/button/close(null, "close", header2, g2.ident, vector(14, 1))

	verb/Say(t as text)
		if (t)
			world << "<span style=\"color: #d35938\">\icon[src][src.name] says: [t]</span>"
