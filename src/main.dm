var/regex/maptext_image = regex(@`\{(\w+)}`, "gi")
var/version/version
var/list/clients
var/list/directors
var/list/join_dir_flags = list(
	list(1, 4, 0, 2, 0, 0, 0, 8),
	list(1, 16, 0, 4, 2, 8, 0, 64, 128, 32)
)
var/list/cursors

// This procedure exists purely to include additional resources in the resource file, such as fonts and style sheets.
proc/additional_resources() as /list
	return list(
		/**
		 * Public Pixel and Vaticanus fonts by GGBotNet (https://www.ggbot.net/)
		 * Licensed under CC0 1.0 (https://creativecommons.org/publicdomain/zero/1.0/)
		 */
		'assets/fonts/PublicPixel.ttf',
		'assets/fonts/Vaticanus.ttf',
		// map.css is a hard copy of the style sheet used by the map element.
		'assets/map.css'
	)

proc/hasvar(datum/d, v) as num
	return (v in d?.vars)

proc/repeattext(t, n) as text
	. = ""

	while (--n >= 0)
		. += t

	return .

proc/error(exception) as text
	. = ""

	if (istype(exception, /exception))
		var/exception/e = exception
#ifdef DEBUG
		. += "[e.file]:[e.line]: "
#endif
		. += e.name

	else
		. = exception

	return .

proc/save_config()
	var/fname = "config.json"

	if (fexists(fname))
		fdel(fname)

	var/f = file(fname)
	var/list/config = list(
		"directors" = ::directors
	)

	f << json_encode(config, JSON_PRETTY_PRINT)

proc/load_config() as /list
	var/fname = "config.json"

	. = list()

	if (fexists(fname))
		try
			. = json_decode(file2text(fname))

		catch (var/exception/e)
			world.log << ::error(e)

	return .

proc/generate_cursors() as /list
	. = new /list(3)
	.[1] = 'assets/cursor.dmi'

	for (var/i in 2 to 3)
		var/icon/cursor = icon('assets/cursor.dmi')

		cursor.Scale(world.icon_size * i, world.icon_size * i)
		.[i] = cursor

	return .
