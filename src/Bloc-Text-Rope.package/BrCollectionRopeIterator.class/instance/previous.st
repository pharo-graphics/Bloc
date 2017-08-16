iterator - enumeration
previous
	| anItem aSize aPosition |
	
	aSize := end.
	
	position <= (aSize + 1)
		ifFalse: [ self error: 'Index out of bounds: ', position asString ].
	
	aPosition := position min: aSize.
	
	anItem := rope collection at: aPosition.
	position := aPosition - 1.
	
	^ anItem