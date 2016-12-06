layout
eatRequestLayout

	eatRequestLayoutCounter := eatRequestLayoutCounter + 1.
	(eatRequestLayoutCounter = 1 and: [ layoutFrozen not ])
		ifTrue: [ layoutRequestEaten := false ]