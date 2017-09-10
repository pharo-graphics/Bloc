anchor - geometry
cornerPosition
	"Return my geometry corner position in parent coordinates,
	that I should have according to my to anchors"
	<return: #Point>

	^ self toAnchor positionWithin: self