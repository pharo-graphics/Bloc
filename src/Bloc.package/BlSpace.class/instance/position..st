accessing
position: aPoint
	"Request to change window's position to a given point in screen corrdinates"

	self hasHostSpace
		ifTrue: [ self hostSpace position: aPoint ]
		ifFalse: [ self setPosition: aPoint ]