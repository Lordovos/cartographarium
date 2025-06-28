var/regex/maptext_image = regex(@`\{(\w+)}`, "gi")
var/version/version
var/list/clients
var/list/directors
var/list/rarities = list("Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic")
var/list/roles = list("Understudy", "Actor", "Director", "Producer")
var/list/join_dir_flags = list(
	list(1, 4, 0, 2, 0, 0, 0, 8),
	list(1, 16, 0, 4, 2, 8, 0, 64, 128, 32)
)

// This procedure exists purely to include additional resources in the resource file, such as fonts and style sheets.
proc/additional_resources() as /list
	return list(
		/**
		 * Public Pixel and Vaticanus fonts by GGBotNet (https://www.ggbot.net/)
		 * Licensed under CC0 1.0 (https://creativecommons.org/publicdomain/zero/1.0/)
		 */
		'assets/fonts/PublicPixel.ttf',
		'assets/fonts/Vaticanus.ttf',
		/**
		 * map.css and chat.css are hard copies of the style sheets used by the map and chat interface elements, respectively.
		 * TODO: Automate updating the interface elements with their respective style sheets. Right now you need to manually copy and paste the contents of the style sheet into the interface element's style parameter in the interface editor.
		 */
		'assets/map.css',
		// 'assets/chat.css'
	)

proc/hasvar(datum/d, v) as num
	return (v in d?.vars)

proc/repeattext(t, n) as text
	. = ""

	while (--n >= 0)
		. += t

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
			world.log << "config.json has invalid formatting:\n[e.name]"

	return .

world
	name = "Cartographarium"
	hub = "LordAndrew.Cartographarium"
	icon_size = 16
	view = "27x19"
	tick_lag = 0.25
	map_format = SIDE_MAP
	movement_mode = TILE_MOVEMENT_MODE
	mob = /mob/character

	New()
		var/list/config = ::load_config()

		::version = new ()
		src.status = "v[::version]"
		::clients = list()
		::directors = config["directors"] || list()

	Del()
		::save_config()

	Tick()
		for (var/client/c in ::clients)
			try
				c.Tick()

			catch ()
