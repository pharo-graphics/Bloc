children - geometry
decoratedMeasuredWidth: anElement
	"Return the measured width of the given child, plus the additional size of any insets applied by ItemDecoration"
	<return: #Number>
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	^ anElement measuredWidth + anInsets width