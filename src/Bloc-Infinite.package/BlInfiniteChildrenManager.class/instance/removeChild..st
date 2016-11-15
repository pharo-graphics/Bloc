children add/remove
removeChild: aChildElement
	| index |
	
	index := controller childIndexOf: aChildElement.
	index <= 0
		ifTrue: [ ^ self ].
	
	(bucket remove: index)
		ifTrue: [ self unhideChildInternal: aChildElement ].

	controller removeChildAt: index