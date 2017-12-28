children - geometry
decoratedTop: anElement
	"Returns the top edge of the given child element within its parent, offset by any applied ItemDecoration"
	<return: #Number>

	^ anElement bounds inParent top - (self topDecorationHeight: anElement)