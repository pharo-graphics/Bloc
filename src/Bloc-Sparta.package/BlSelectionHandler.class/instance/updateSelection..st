selection
updateSelection: anElement
		
	(anElement boundsInSpace intersects: self selectionArea)
		ifFalse: [ ^ self ].

	anElement fireEvent: (BlSelectionEvent new
		area: self selectionArea).

	anElement childrenDo: [ :each | self updateSelection: each ]