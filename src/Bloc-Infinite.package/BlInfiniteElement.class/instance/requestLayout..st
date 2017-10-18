layout
requestLayout: anElement
	
	"Layout may be requested by one of my children.
	If it is the case we should let layout request to pass further"
	anElement == self
		ifFalse: [ ^ super requestLayout: anElement ].

	(eatRequestLayoutCounter isZero and: [ layoutFrozen not ])
		ifTrue: [ super requestLayout: anElement ]
		ifFalse: [ self markLayoutRequestEaten ]