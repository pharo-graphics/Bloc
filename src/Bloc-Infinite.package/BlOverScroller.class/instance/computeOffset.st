scrolling
computeOffset

	self isFinished
		ifTrue: [ ^ false ].
		
	mode = Scroll
		ifTrue: [ self computeOffsetScroll ].
		
	mode = Fling
		ifTrue: [ self computeOffsetFling ].
		
	^ true