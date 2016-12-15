physics
startSpringbackFor: aVelocity start: aStart end: anEnd
	| aDelta |
	
	"mStartTime has been set"
	isFinished := false.
	state := Cubic.
	startPosition := aStart.
	currentPosition := aStart.
	finalPosition := anEnd.
	
	aDelta := aStart - anEnd.
	deceleration := self decelerationFor: aDelta.
	startVelocity := aDelta negated.
	overshotDistance := aDelta abs.
	duration := 1000.0 * (-2.0 * aDelta / deceleration) sqrt