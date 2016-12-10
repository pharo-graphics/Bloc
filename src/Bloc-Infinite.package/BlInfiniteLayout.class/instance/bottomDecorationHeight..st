children - geometry
bottomDecorationHeight: anElement
	"Returns the total width of item decorations applied to child's bottom"
	<return: #Number>
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	^ anInsets bottom