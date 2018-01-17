api - accessing
first
	^ self hasPrevious
		ifTrue: [ self previous first ]
		ifFalse: [ self ]