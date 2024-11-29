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

	proc/Append(maptext)
		src.maptext += "<p style=\"font-family: 'Public Pixel'; font-size: 6px; margin: 0 8px; color: #fff; vertical-align: top; line-height: 1;\">[maptext]</p>"
