geometry bounds convertion
localBoundsToWindow: aBounds
	"In-place transform bounds from local coordinates to device window coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>
	
	"Checking for very common mistake"
	aBounds isRectangle
		ifTrue: [ self error: 'Was given a Rectangle ', aBounds asString, ' while it should be BlBounds' ].

	"First we need to transform provided bounds from my local coordinates to parent ones"
	self localBoundsToGlobal: aBounds.

	"and then delegate transformation to my parent if I have one"
	self isAttachedToSceneGraph
		ifTrue: [ aBounds scaleBy: self space windowScale ].

	^ aBounds