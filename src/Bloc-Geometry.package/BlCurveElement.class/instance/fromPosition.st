anchor - geometry
fromPosition
	"Return position of fromAnchor in parent coordinates.
	The actual path may not start from this position if there exist arrow heads"
	<return: #Point>

	^ self fromAnchor positionWithin: self