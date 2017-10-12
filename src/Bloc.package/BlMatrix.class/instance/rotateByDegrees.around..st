matrix - transformations
rotateByDegrees: aNumber around: aBlVector
	"Apply a rotation transformation by a given amount of degrees around a provided axis vector"
	
	self rotateByRadians: aNumber degreesToRadians around: aBlVector