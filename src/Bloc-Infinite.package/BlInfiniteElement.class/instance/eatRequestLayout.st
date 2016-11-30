layout
eatRequestLayout

	eatRequestLayout := eatRequestLayout + 1.
	(eatRequestLayout = 1 and: [ layoutFrozen not ])
		ifTrue: [ layoutRequestEaten := false ]