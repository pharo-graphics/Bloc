children - geometry
decoratedBottom: anElement
	"Returns the bottom edge of the given child element within its parent, offset by any applied ItemDecoration"
	<return: #Number>

	^ anElement bounds inParent bottom + (self bottomDecorationHeight: anElement)