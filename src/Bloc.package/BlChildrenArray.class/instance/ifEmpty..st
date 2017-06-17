testing
ifEmpty: aBlock
	^ array
		ifEmpty: aBlock
		ifNotEmpty: [ self ]