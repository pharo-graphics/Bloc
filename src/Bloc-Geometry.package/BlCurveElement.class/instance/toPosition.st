anchor - geometry
toPosition
	"Return position of toAnchor in parent coordinates.
	The actual path may not end at this position if there exist arrow heads"
	<return: #Point>

	^ self toAnchor positionWithin: self