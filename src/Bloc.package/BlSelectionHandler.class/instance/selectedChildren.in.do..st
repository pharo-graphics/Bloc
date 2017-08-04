selection
selectedChildren: anElement in: aBlBounds do: aBlock
	"Evaluate a block with all children of an element that intersect with provided bounds.
	aBlBounds is given in local coordinates of anElement"	

	((self shouldSelect: anElement in: aBlBounds)
		and: [ (aBlock value: anElement value: aBlBounds) not ])
			ifFalse: [ ^ self ].
		
	anElement childrenDo: [ :aChild |	
		| boundsInLocal |
		boundsInLocal := aChild parentBoundsToLocal: aBlBounds copy.
		self
			selectedChildren: aChild
			in: boundsInLocal
			do: aBlock ]