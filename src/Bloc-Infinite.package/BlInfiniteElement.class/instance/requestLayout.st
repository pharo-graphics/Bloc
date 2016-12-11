layout
requestLayout

	(eatRequestLayoutCounter isZero and: [ layoutFrozen not ])
		ifTrue: [ super requestLayout ]
		ifFalse: [ self markLayoutRequestEaten ]