matrix - transformations
rotateByRadians: aTheta around: aBlVector
	"Apply a rotation transformation by a given amount of radians around a provided axis vector"
	| aRotationMatrix |
	
	aRotationMatrix := self class rotation: aTheta axis: aBlVector.
	self multiplyBy: aRotationMatrix