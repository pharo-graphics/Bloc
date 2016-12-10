children - geometry
topDecorationHeight: anElement
	"Returns the total width of item decorations applied to child's top"
	<return: #Number>
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	^ anInsets top