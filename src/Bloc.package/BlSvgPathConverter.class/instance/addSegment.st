adding
addSegment

	| sel args |
	sel := 	thisContext sender selector.
	args := thisContext sender arguments.
	"update min/max for calculatin bounding box"
	
	path add: { sel. args }