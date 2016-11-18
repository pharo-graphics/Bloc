children add/remove
removeChildAt: anIndex
	"Remove a child at anIndex from infinite element
	and do not track it anymore."
	| offset child |
	offset := self computeOffset: anIndex.
	child := controller childAt: anIndex.
	child
		ifNil: [ ^ self ].
		
	(bucket remove: offset)
		ifTrue: [ self unhideChildInternal: child ].

	controller removeChildAt: anIndex