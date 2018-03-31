private - children
lastReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState
	<return: #BlElement or: nil>

	^ self
		referenceChildWithin: (self childrenCount to: 1)
		between: (1 to: self state itemCount)
		recycler: aBlInfiniteRecycler
		state: aBlInfiniteState