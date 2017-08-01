selection
selectedChildren: anElement in: aBlBounds do: aBlock
	"Evaluate a block with all children of an element that intersect with provided bounds.
	aBlBounds is given in local coordinates of anElement"
	
	anElement childrenDo: [ :aChild |
		| boundsInLocal |
		boundsInLocal := aChild parentBoundsToLocal: aBlBounds copy.
		((self shouldSelect: aChild in: boundsInLocal) and: [ (aBlock value: aChild value: boundsInLocal) not ])
			ifTrue: [ 
				self
					selectedChildren: aChild
					in: boundsInLocal
					do: aBlock ] ]