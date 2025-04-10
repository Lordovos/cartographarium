obj/menu
	icon = 'assets/menu.dmi'
	plane = 2

	var/ident
	var/client/owner
	var/width = 1
	var/height = 1
	var/list/components

	New(loc, ident, client/owner, vector/size = vector(src.width, src.height), vector/position = vector(1, 1), vector/offset = vector(0, 0))
		src.ident = ident
		src.owner = astype(owner)
		src.owner?.SetMenu(src.ident, src)
		src.width = size.x
		src.height = size.y
		src.components = list()
		src.Draw(position, offset)

	proc/Draw(vector/position, vector/offset)
		src.screen_loc = "[position.x]:[offset.x],[position.y]:[offset.y]"

	proc/Get(ident)
		return src.components?[ident]

	proc/Set(ident, obj/menu/component/component)
		if (istype(component))
			src.components?[ident] = component

	proc/Show()
		src.owner?.screen += src

	proc/Hide()
		src.owner?.screen -= src

		for (var/ident in src.components)
			src.Get(ident)?.Clear()
