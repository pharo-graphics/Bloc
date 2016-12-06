children - geometry
leftDecorationWidth: anElement
	"Returns the total width of item decorations applied to child's left"
	<return: #Number>
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	^ anElement left