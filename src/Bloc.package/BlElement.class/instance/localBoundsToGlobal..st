geometry bounds convertion
localBoundsToGlobal: aSpartaRectangle
	"In-place transform bounds from local coordinates to global space coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #SpartaRectangle>

	"First we need to transform provided bounds from my local coordinates to parent ones"
	self localBoundsToParent: aSpartaRectangle.

	"and then delegate transformation to my parent if I have one"
	self hasParent
		ifTrue: [ self parent localBoundsToGlobal: aSpartaRectangle ].

	^ aSpartaRectangle