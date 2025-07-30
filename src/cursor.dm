cursor
	var/client/owner
	var/atom/movable/selection

	New(client/owner)
		src.owner = astype(owner)

	proc/Select(atom/movable/m)
		src.selection = astype(m)

	proc/Selection() as /atom/movable
		return src.selection

	proc/Update()
		if (src.owner)
			src.owner.mouse_pointer_icon = ::cursors[src.owner.zoom]
