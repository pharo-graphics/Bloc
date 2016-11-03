private utilities
fits: anArray from: fromIndex to: toIndex with: value
	
	(toIndex > anArray size)
		ifTrue: [ ^ false ].

	^ (fromIndex to: toIndex) allSatisfy: [ :i | (anArray at: i) <= value ]