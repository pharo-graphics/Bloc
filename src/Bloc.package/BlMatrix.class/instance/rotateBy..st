matrix - transformations
rotateBy: aNumber
	"Apply a rotation transformation by a given amount of degrees around z-axis"
	
	self
		rotateByDegrees: aNumber
		around: BlVector zAxis