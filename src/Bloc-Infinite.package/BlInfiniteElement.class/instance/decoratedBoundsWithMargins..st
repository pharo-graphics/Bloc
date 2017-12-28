children - geometry
decoratedBoundsWithMargins: anElement
	"Returns the bounds of the child element including its decoration and margins"
	<return: #Rectangle>
	| aMargin anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	aMargin := anElement constraints margin.
	
	^ anInsets expand: (aMargin expand: anElement bounds inParent asRectangle)