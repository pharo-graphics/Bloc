children add/remove
removeChildAt: anIndex
	"Remove a child at anIndex from infinite element
	and do not track it anymore."
	| anOffset anElement |
	
	anOffset := self computeOffset: anIndex.
	self
		assert: [ anOffset >= 0 ]
		description: [ 'Index must be positive!' ].
		
	anElement := controller childAt: anIndex.
	anElement
		ifNil: [ ^ self ].

	(bucket remove: anOffset)
		ifTrue: [ self unhideChildInternal: anElement ].

	controller removeChildAt: anIndex