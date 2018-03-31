scrolling
computeOffset
	"Call this when you want to know the new location.
	If it returns true, the animation is not yet finished."
	<return: #Boolean>

	self isFinished
		ifTrue: [ ^ false ].

	mode = Scroll
		ifTrue: [ self computeOffsetScroll ].

	mode = Fling
		ifTrue: [ self computeOffsetFling ].

	^ true