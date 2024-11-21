var/version/version

/*
	This procedure exists purely to include additional resources in the resource file, such as fonts.
*/
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

obj/menu
	plane = 2

	var/list/slices
	var/obj/menu/text_field/text_field

	New()
		..()
		src.slices = list()

obj/menu/slice
	parent_type = /obj
	icon = 'assets/menu.dmi'
	plane = 2
	layer = 1

	New(loc, icon_state)
		..()
		src.icon_state = icon_state

obj/menu/text_field
	parent_type = /obj
	plane = 2
	layer = 2
	maptext_y = 8

	New(loc, maptext_width, maptext_height)
		..()
		src.maptext_width = maptext_width
		src.maptext_height = maptext_height

	proc/Set(maptext)
		src.maptext = "<p style=\"font-family: 'Public Pixel'; font-size: 6px; margin: 0 8px; color: #fff; vertical-align: top; line-height: 1;\">[maptext]</p>"

obj/menu/group
	parent_type = /datum

	var/alist/menus

	New()
		src.menus = alist()

	proc/Get(key)
		return src.menus?[key]

	proc/Set(key, value)
		src.menus?[key] = value

obj/menu
	proc/Draw(vector/size = vector(1, 1), vector/position = vector(1, 1), vector/offset = vector(0, 0))

// TODO: Convert into a procedure for the menu prototype. Optimize for menus less than 2 tiles wide or tall. Convert repeated results to variables.
mob/proc/DrawMenu(width, height, x = 1, y = 1, offset_x = 0, offset_y = 0, maptext = "")
	var/const/SLICE_SIZE = 8
	var/obj/menu/menu = new ()
	var/obj/menu/slice/bl = new (menu, "corner")
	var/obj/menu/slice/b = new (menu, "side")
	var/obj/menu/slice/br = new (menu, "corner")
	var/obj/menu/slice/l = new (menu, "side")
	var/obj/menu/slice/c = new (menu, "center")
	var/obj/menu/slice/r = new (menu, "side")
	var/obj/menu/slice/tl = new (menu, "corner")
	var/obj/menu/slice/t = new (menu, "side")
	var/obj/menu/slice/tr = new (menu, "corner")

	bl.transform = matrix().Translate(0, 0)
	b.transform = matrix().Scale(((width * SLICE_SIZE) / SLICE_SIZE) - 1, 1).Translate((width * SLICE_SIZE) / 2, 0)
	br.transform = matrix().Turn(270).Translate(width * SLICE_SIZE, 0)
	l.transform = matrix().Turn(90).Scale(1, ((height * SLICE_SIZE) / SLICE_SIZE) - 1).Translate(0, (height * SLICE_SIZE) / 2)
	c.transform = matrix().Scale(((width * SLICE_SIZE) / SLICE_SIZE) - 1, ((height * SLICE_SIZE) / SLICE_SIZE) - 1).Translate((width * SLICE_SIZE) / 2, (height * SLICE_SIZE) / 2)
	r.transform = matrix().Turn(270).Scale(1, ((height * SLICE_SIZE) / SLICE_SIZE) - 1).Translate(width * SLICE_SIZE, (height * SLICE_SIZE) / 2)
	tl.transform = matrix().Turn(90).Translate(0, height * SLICE_SIZE)
	t.transform = matrix().Turn(180).Scale(((width * SLICE_SIZE) / SLICE_SIZE) - 1, 1).Translate((width * SLICE_SIZE) / 2, height * SLICE_SIZE)
	tr.transform = matrix().Turn(180).Translate(width * SLICE_SIZE, height * SLICE_SIZE)

	menu.text_field = new (menu, (width * SLICE_SIZE) + SLICE_SIZE, (height * SLICE_SIZE) - SLICE_SIZE)
	menu.text_field.Set(maptext)
	menu.slices += list(bl, b, br, l, c, r, tl, t, tr, menu.text_field)
	menu.vis_contents += menu.slices
	menu.screen_loc = "[x]:[offset_x],[y]:[offset_y]"
	src.client.screen += menu
/*
mob/verb/UpdateTextbox()
	var/str = "Hello, world! These are some tests."
	var/buffer = ""

	for (var/i = 1 to length(str))
		buffer += str[i]
		src.textbox?.Set(buffer)
		sleep (1)
*/
mob/verb/ClearScreen()
	src.client.screen.Cut()

mob/verb/Grid()
	var/obj/o = new /obj{icon = 'assets/tileset.dmi'; icon_state = "grid"; plane = 3; alpha = 128}()

	o.screen_loc = "SOUTHWEST to NORTHEAST"
	src.client.screen += o

// max_width = 53
// max_height = 37

mob/verb/Menu()
	var/t = "Hello, world!\n\nYou are [src.name].\n\nCartographarium v[::version]\n\nDream Maker v[DM_VERSION].[DM_BUILD]\n\n"

#ifdef DEBUG
	t += "Debug Mode\n"
#else
	t += "Release Mode\n"
#endif
	src.DrawMenu(20, 2, 1, 18, 0, 8, "Menu\n")
	src.DrawMenu(20, 34, 1, 1, 0, 0, t)

mob/verb/MenuLoop()
	for (var/i = 1 to 64)
		src.DrawMenu(rand(1, 53), rand(1, 37))
		sleep (1)
