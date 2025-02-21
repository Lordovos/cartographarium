obj/waypoint
	icon = 'assets/tileset.dmi'
	icon_state = "waypoint"
	alpha = 64

	var/is_active = TRUE as anything in list(TRUE, FALSE)

obj/waypoint/start
// TODO: Convert the hardcoded starting waypoint to use an instance with a tag.
