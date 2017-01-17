geometry bounds convertion
localBoundsToWindow: aSpartaRectangle
	"In-place transform bounds from local coordinates to device window coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #SpartaRectangle>
	
	"Checking for very common mistake"
	aSpartaRectangle isRectangle
		ifTrue: [ self error: 'Was give a Rectangle ', aSpartaRectangle asString, ' while it should be SpartaRectangle' ].

	"First we need to transform provided bounds from my local coordinates to parent ones"
	self localBoundsToGlobal: aSpartaRectangle.

	"and then delegate transformation to my parent if I have one"
	self isAttachedToSceneGraph
		ifTrue: [ aSpartaRectangle scaleBy: self space windowScale ].

	^ aSpartaRectangle