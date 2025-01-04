mob/character
	icon = 'assets/characters.dmi'
	icon_state = "base"
	pixel_y = 4

	Login()
		..()
		var/obj/waypoint/start/start = locate()

		if (start)
			src.loc = start.loc

		var/obj/menu/group/g = new ("debug")
		var/obj/menu/header = new (null, "header", vector(15, 2), vector(1, 13))
		var/obj/menu/body = new (null, "body", vector(15, 23))

		g.Set(header.ident, header)
		g.Set(body.ident, body)
		src.client.SetMenu(g.ident, g)

	verb/Say(t as text)
		if (t)
			world << "<span style=\"color: #d35938\">\icon[src][src.name] says: [t]</span>"
