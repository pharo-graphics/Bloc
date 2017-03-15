anchor - geometry
originPosition
	"Return my geometry origin position in parent coordinates,
	that I should have according to my from anchors"
	<return: #Point>
	
	^ self localPointToParent: (self fromAnchor positionWithin: self)