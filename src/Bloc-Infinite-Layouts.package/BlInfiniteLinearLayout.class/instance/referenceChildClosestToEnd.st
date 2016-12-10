children - accessing
referenceChildClosestToEnd
	"Among the children that are suitable to be considered as an anchor child,
	return the one closest to the end of the layout"
	<return: #BlElement or: nil>

	^ shouldReverseLayout
		ifTrue: [	self firstReferenceChild ]
		ifFalse: [ self lastReferenceChild ]