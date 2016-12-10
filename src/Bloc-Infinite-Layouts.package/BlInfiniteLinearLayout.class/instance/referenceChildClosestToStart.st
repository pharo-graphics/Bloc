children - accessing
referenceChildClosestToStart
	"Among the children that are suitable to be considered as an anchor child,
	return the one closest to the start of the layout"
	<return: #BlElement or: nil>

	^ shouldReverseLayout
		ifTrue: [	self lastReferenceChild ]
		ifFalse: [ self firstReferenceChild ]