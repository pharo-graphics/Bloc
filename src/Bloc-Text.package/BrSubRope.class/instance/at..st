rope - accessing
at: anIndex
	anIndex > length
		ifTrue: [ self error: 'Sub rope index out of bounds: ', anIndex asString ].
	
	^ rope at: offset + anIndex