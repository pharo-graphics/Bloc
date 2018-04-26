hooks
onEdgeReached
	| aSquaredVelocity aDistance |
	"startPosition, startVelocity and startTime were adjusted to their values when edge was reached"
	
	aSquaredVelocity := startVelocity * startVelocity.
	aDistance := aSquaredVelocity / (2.0 * deceleration abs).
	
	(aDistance > overshotDistance)
		ifTrue: [ 
			"Default deceleration is not sufficient to slow us down before boundary"
			deceleration := (startVelocity sign negated * aSquaredVelocity ) / (2.0 * overshotDistance).
			aDistance := overshotDistance	].
	
	"overshot distance must not contain fractional numbers"
	overshotDistance := self truncated: aDistance.
	
	currentStep := BlSplineOverScrollerStep ballistic.
	finalPosition := startPosition + (self truncated: (startVelocity > 0
		ifTrue: [ aDistance ]
		ifFalse: [ aDistance negated ])).
	
	duration := (self truncated: (1000 * startVelocity / deceleration)) negated milliSeconds