geometry bounds convertion
parentBoundsToLocal: aBounds
	"In-place transform bounds from my parent's coordinates to local coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>

	"first apply inverted transformation if we have one"
	transform inverseTransformBounds: aBounds.

	"then translate according to my position within the parent.
	Note, that an element might have a position even if it does not have a parent"
	aBounds translateBy: self position negated.
	
	^ aBounds