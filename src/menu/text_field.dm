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
		src.maptext = "<p>[maptext]</p>"

	proc/Append(maptext)
		src.maptext += "<p>[maptext]</p>"
