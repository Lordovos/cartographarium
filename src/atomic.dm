atom
	proc/Bumped(atom/movable/m)

atom/movable
	step_size = 16
	appearance_flags = PIXEL_SCALE | LONG_GLIDE

	Bump(atom/a)
		a.Bumped(src)
		..()

	proc/Step(dir = src.dir, delay)
		src.glide_size = delay ? src.step_size / (delay / world.tick_lag) : src.step_size
		return step(src, dir)

area
	layer = BACKGROUND_LAYER + 1

turf
	layer = BACKGROUND_LAYER + 2

obj
	layer = 1

mob
	layer = 2

	var/tmp/next_step = 0 as num
	var/tmp/step_delay = 1 as num

	Step(dir = src.dir, delay = src.step_delay)
		if (src.next_step <= world.time)
			. = ..()
			src.next_step = max(src.next_step, world.time + delay)
			return .

		return 0
