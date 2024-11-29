var/version/version

// This procedure exists purely to include additional resources in the resource file, such as fonts.
proc/additional_resources()
	return list(
		/*
			Public Pixel font by GGBotNet (https://ggbot.itch.io/)
			Licensed under CC0 1.0 (https://creativecommons.org/publicdomain/zero/1.0/)
		*/
		'assets/fonts/PublicPixel.ttf'
	)

world
	name = "Cartographarium"
	hub = "LordAndrew.Cartographarium"
	icon_size = 16
	view = "27x19"
	tick_lag = 0.25
	map_format = SIDE_MAP
	movement_mode = TILE_MOVEMENT_MODE
	mob = /mob/character

	New()
		::version = new ()

obj/crate
	icon = 'assets/tileset.dmi'
	icon_state = "crate"
	density = TRUE

	Bumped(atom/movable/m)
		step(src, m.dir)

obj/star
	icon = 'assets/tileset.dmi'
	icon_state = "sol"

	Click()
		world << src.name

	MouseEntered()
		src.filters += filter(type = "outline", color = "#fff", flags = OUTLINE_SHARP)

	MouseExited()
		src.filters = list()

mob/verb/NewMenu()
	var/obj/menu/header = new (null, "about-header", vector(20, 2), vector(1, 18), vector(0, 8))
	var/obj/menu/body = new (null, "about-body", vector(20, 34))
	var/obj/menu/group/g = new ("group-about")
	var/t = "Cartographarium\nv[::version]\n\nDream Maker\nv[DM_VERSION].[DM_BUILD]\n\n"

#ifdef DEBUG
	t += "Debug Mode"
#else
	t += "Release Mode"
#endif
	header.text_field.Set("About")
	body.text_field.Set(t)
	g.Set(header.ident, header)
	g.Set(body.ident, body)
	src.client.SetMenu(g.ident, g)
	src.client.ShowMenu(g.ident)

mob/verb/OpenMenu()
	src.client.ShowMenu("group-about")

mob/verb/ShowText()
	src.client.GetMenu("group-about").Get("about-body").text_field.vis_flags &= ~VIS_HIDE

mob/verb/HideText()
	src.client.GetMenu("group-about").Get("about-body").text_field.vis_flags |= VIS_HIDE

mob/verb/CloseMenu()
	src.client.HideMenu("group-about")

mob/verb/SetMenuText(t as text)
	src.client.GetMenu("group-about").Get("about-body").text_field.Append(t)

mob/verb/ClearScreen()
	src.client.screen.Cut()

mob/verb/Grid()
	var/obj/o = new /obj{icon = 'assets/tileset.dmi'; icon_state = "grid"; plane = 3; alpha = 128}()

	o.screen_loc = "SOUTHWEST to NORTHEAST"
	src.client.screen += o
