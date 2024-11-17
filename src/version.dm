/*
	/version is a prototype that tracks the current version of the project.
*/
version
	var/major
	var/minor
	var/patch

	New(major = 0, minor = 0, patch = 0)
		src.major = major
		src.minor = minor
		src.patch = patch

	proc/operator""()
		return "[src.major].[src.minor].[src.patch]"
