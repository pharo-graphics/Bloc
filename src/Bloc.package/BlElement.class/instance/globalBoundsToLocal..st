geometry bounds convertion
globalBoundsToLocal: aBounds
"In-place transform bounds from global space coordinates to local coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>

	"Checking for very common mistake"
	aBounds isRectangle
		ifTrue: [ self error: 'Was given a Rectangle ', aBounds asString, ' while it should be Bounds' ].

	"First we need to transform provided bounds from parent coordinates to my local ones"
	self parentBoundsToLocal: aBounds.

	"and then delegate transformation to my parent if I have one"
	self hasParent
		ifTrue: [ self parent globalBoundsToLocal: aBounds ].

	^ aBounds