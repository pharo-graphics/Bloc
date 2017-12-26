geometry position
positionInSpace
	"Return my position in space coordinates.
	Note: If I don't have a parent I return position that was previously set by #relocate:"
	<return: #Point>

	^ self localPointToGlobal: 0@0