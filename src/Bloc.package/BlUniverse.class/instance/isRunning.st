testing
isRunning
	"Return true if I am running, false otherwise"
	<return: #Boolean>

	^ pulseLoop isNotNil and: [ pulseLoop isRunning ]