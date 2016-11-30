layout
resumeRequestLayout: shouldPerformLayout
	
	eatRequestLayout < 1
		ifTrue: [ self error: 'Invalid eat request layout count' ].

	shouldPerformLayout
		ifFalse: [ layoutRequestEaten := false ].
	
	eatRequestLayout = 1 ifTrue: [ 
		(shouldPerformLayout and: [
			layoutRequestEaten and: [ 
				layoutFrozen not ] ])
			ifTrue: [ self dispatchLayout ].
		layoutFrozen
			ifFalse: [ layoutRequestEaten := false ] ].
		
	eatRequestLayout := eatRequestLayout - 1