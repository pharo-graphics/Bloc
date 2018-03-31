private - children
referenceChildClosestToStartIn: aBlInfiniteRecycler state: aBlInfiniteState
	"Among the children that are suitable to be considered as an anchor child,
	return the one closest to the start of the layout"
	<return: #BlElement or: nil>

	^ shouldReverseLayout
		ifTrue: [	self lastReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState ]
		ifFalse: [ self firstReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState ]