selection
selectedChildren: anElement do: aBlock in: aBlBounds
	"Evaluate a block with all children of an element that intersect with provided bounds.
	aBlBounds is given in local coordinates of anElement"
	| boundsInParent |
	
	boundsInParent := BlBounds new.
	
	anElement children
		select: [ :aChild | self shouldSelect: aChild in: aBlBounds ]
		thenDo: [  ]