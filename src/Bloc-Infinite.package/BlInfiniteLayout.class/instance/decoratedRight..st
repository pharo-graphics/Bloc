children - geometry
decoratedRight: anElement
	"Returns the right edge of the given child element within its parent, offset by any applied ItemDecoration"
	<return: #Number>

	^ anElement bounds inParent right + (self rightDecorationWidth: anElement)