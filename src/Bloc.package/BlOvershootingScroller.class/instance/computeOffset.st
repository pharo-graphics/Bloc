scrolling
computeOffset
	"Call this when you want to know the new location.
	If it returns true, the animation is not yet finished."
	<return: #Boolean>

	self isFinished
		ifTrue: [ ^ false ].

	self time synchronized: [
		scrollerX run.
		scrollerY run ].

	^ true