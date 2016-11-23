children - geometry
decoratedMeasuredHeight: anElement
	"Return the measured height of the given child, plus the additional size of any insets applied by ItemDecoration"
	<return: #Number>
	| anInsets |
	
	anInsets := anElement constraints infinite decorationInsets.
	^ anElement measuredHeight + anInsets height