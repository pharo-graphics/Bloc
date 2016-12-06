layout
resumeRequestLayout: shouldPerformLayout
	
	eatRequestLayoutCounter < 1
		ifTrue: [ self error: 'Invalid eat request layout count' ].

	shouldPerformLayout
		ifFalse: [ layoutRequestEaten := false ].
	
	eatRequestLayoutCounter = 1 ifTrue: [ 
		(shouldPerformLayout and: [
			layoutRequestEaten and: [ 
				layoutFrozen not ] ])
			ifTrue: [ self dispatchLayout ].
		layoutFrozen
			ifFalse: [ layoutRequestEaten := false ] ].
		
	eatRequestLayoutCounter := eatRequestLayoutCounter - 1