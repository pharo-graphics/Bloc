children - geometry
rightDecorationWidth: anElement
	"Returns the total width of item decorations applied to child's right"
	<return: #Number>
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	^ anInsets right