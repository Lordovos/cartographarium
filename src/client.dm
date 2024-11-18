client
	tick_lag = 0.01

	Move(loc, dir)
		walk(src.mob, 0)
		return src.mob.Step(dir)
