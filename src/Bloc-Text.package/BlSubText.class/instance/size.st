text - accessing
size
	self assertInvariant.

	^ (start = end and: [ start isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ end - start + 1 ]