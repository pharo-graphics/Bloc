children add/remove
removeChildAt: anIndex
	| offset child |
	offset := self computeOffset: anIndex.
	child := controller childAt: anIndex.
	child
		ifNil: [ ^ self ].
		
	(bucket remove: offset)
		ifTrue: [ self unhideChildInternal: child ].

	controller removeChildAt: anIndex