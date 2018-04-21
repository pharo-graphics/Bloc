api - running
run
	"Run a simulation step and return true if animation is not finished"
	<return: #Boolean>

	self isFinished
		ifTrue: [ ^ false ].

	self update
		ifTrue: [ ^ true ].

	self continue
		ifTrue: [ ^ true ].

	self finish.
	^ false