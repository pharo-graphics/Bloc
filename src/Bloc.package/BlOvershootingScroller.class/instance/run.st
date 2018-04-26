api - running
run
	"Call this when you want to know the new location.
	If it returns true, the animation is not yet finished."
	<return: #Boolean>

	self isFinished
		ifTrue: [
			self notifyRun: false.
			^ false ].

	self time synchronized: [
		scrollerX run.
		scrollerY run ].

	self notifyRun: true.
	^ true