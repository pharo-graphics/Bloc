children - accessing
childAtPosition: aPosition
	"@see BlInfiniteLayout>>#childAtPosition:"
	<return: #BlElement or: nil>
	| aFirstChildPosition anElementPosition |

	self hasChildren
		ifFalse: [ ^ nil ].

	aFirstChildPosition := self childPositionOf: (self childAt: 1).
	anElementPosition := aPosition - aFirstChildPosition.
	(anElementPosition between: 1 and: self childrenCount)
		ifTrue: [ 
			| anElement |
			anElement := self childAt: anElementPosition.
			(self childPositionOf: anElement) = aPosition
				"in pre-layout, this may not match"
				ifTrue: [ ^ anElement ] ].
	
	"fallback to traversal. This might be necessary in pre-layout."
	^ super childAtPosition: aPosition