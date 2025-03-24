atom
	proc/Bumped(atom/movable/m)
	proc/OnInteract(mob/m)

atom/movable
	step_size = 16
	appearance_flags = LONG_GLIDE | PIXEL_SCALE

	Bump(atom/a)
		a?.Bumped(src)
		..()

	proc/Step(dir = src.dir, delay)
		src.glide_size = delay ? src.step_size / (delay / world.tick_lag) : src.step_size
		return step(src, dir)

area
	layer = BACKGROUND_LAYER + 1

turf
	layer = BACKGROUND_LAYER + 2

	var/can_join = FALSE in list(TRUE, FALSE)
	var/turf/join_type

	proc/Join()
		var/turf/t
		var/flag = 0

		for (var/d in list(NORTH, EAST, SOUTH, WEST))
			t = get_step(src, d)

			if (!t || (t.type == src.type || (src.join_type && istype(t, src.join_type))))
				flag |= ::join_dir_flags[d]

			else
				flag &= ~::join_dir_flags[d]

		src.OnJoin(flag)

	proc/OnJoin(flag)

obj
	layer = 1

mob
	layer = 2

	var/tmp/next_step = 0 as num
	var/tmp/step_delay = 2 as num

	Step(dir = src.dir, delay = src.step_delay)
		if (src.next_step <= world.time)
			. = ..()
			src.next_step = max(src.next_step, world.time + delay)
			return .

		return 0
