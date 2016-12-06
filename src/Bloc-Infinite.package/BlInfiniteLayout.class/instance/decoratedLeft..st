children - geometry
decoratedLeft: anElement
	"Returns the left edge of the given child element within its parent, offset by any applied ItemDecoration"
	<return: #Number>

	^ anElement boundsInParent left - self leftDecorationWidth: anElement