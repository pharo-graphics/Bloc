private - children
referenceChildClosestToEndIn: aBlInfiniteRecycler state: aBlInfiniteState
	"Among the children that are suitable to be considered as an anchor child,
	return the one closest to the end of the layout"
	<return: #BlElement or: nil>

	^ shouldReverseLayout
		ifTrue: [	self firstReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState ]
		ifFalse: [ self lastReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState ]