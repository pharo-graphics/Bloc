physics
startSpringbackFor: aVelocity start: aStartPosition end: anEndPosition
	| aDelta |
	
	"mStartTime has been set"
	isFinished := false.
	currentStep := Cubic.
	startPosition := aStartPosition.
	currentPosition := aStartPosition.
	finalPosition := anEndPosition.
	
	aDelta := aStartPosition - anEndPosition.
	deceleration := self decelerationFor: aDelta.
	startVelocity := aDelta negated.
	overshotDistance := aDelta abs.
	duration := 1000 milliSeconds * (-2.0 * aDelta / deceleration) sqrt