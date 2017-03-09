iterator - enumeration
next
	| anItem aPosition |	
	position >= 0
		ifFalse: [ self error: 'Index out of bounds: ', position asString ].
	
	aPosition := position max: 1.
	
	anItem := rope collection at: aPosition.
	position := aPosition + 1.

	^ anItem