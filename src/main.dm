var/version/version

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

obj/menu/slice
	parent_type = /obj
	icon = 'assets/menu.dmi'

	New(loc, icon_state)
		..()
		src.icon_state = icon_state

// TODO: Convert into a procedure for the menu prototype. Optimize for menus less than 2 tiles wide or tall. Convert repeated results to variables.
mob/proc/DrawMenu(width, height)
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

	menu.vis_contents += list(bl, b, br, l, c, r, tl, t, tr)
	menu.screen_loc = "1,1"
	src.client.screen += menu

mob/verb/ClearScreen()
	src.client.screen.Cut()

// max_width = 53
// max_height = 37

mob/verb/Menu()
	src.DrawMenu(1, 1)

mob/verb/MenuLoop()
	for (var/i = 1 to 32)
		src.DrawMenu(rand(1, 53), rand(1, 37))
		sleep (5)
