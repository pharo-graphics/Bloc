calculating
alignLine: aLine
	| totalWeight lastChild excessLength excessOffset |
	aLine isEmpty
		ifTrue: [ ^ self ].

	totalWeight := aLine children
		inject: 0
		into: [ :aTotalWeight :aChild | aTotalWeight + aChild weight ].

	lastChild := aLine children last.
	excessLength := aLine length - (lastChild length + lastChild spacingLength + lastChild startLength).
	excessOffset := 0.

	aLine children do: [ :aChild |
		| extraLength childLength childBreadth allowedBounds origin alignment |
		extraLength := totalWeight isZero
			ifTrue: [ excessLength / aLine children size ]
			ifFalse: [ excessLength * aChild weight / totalWeight ].
		childLength := aChild length + aChild spacingLength.
		childBreadth := aChild breadth + aChild spacingBreadth.
	
		alignment := aChild alignment.
		alignment := alignment directed: self direction.
		alignment := self orientation isHorizontal
			ifTrue: [ alignment ]
			ifFalse: [ alignment inverted ].

		allowedBounds := 0 @ excessOffset extent: (childLength + extraLength) @ aLine breadth.
		origin := alignment translate: (0 @ excessOffset extent: childLength @ childBreadth) in: allowedBounds.
		excessOffset := excessOffset + extraLength.
		
		aChild startLength: origin x + aChild startLength.
		aChild startBreadth: origin y ]