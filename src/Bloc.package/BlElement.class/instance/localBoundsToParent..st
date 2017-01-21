geometry bounds convertion
localBoundsToParent: aSpartaRectangle
	"In-place transform bounds from local coordinates to my parent's coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #SpartaRectangle>

	"first apply transformation if we have one"
	transform transformRectangle: aSpartaRectangle.

	"then translate according to my position within the parent.
	Note, that an element might have a position even if it does not have a parent"
	aSpartaRectangle translateBy: self position.
	
	^ aSpartaRectangle