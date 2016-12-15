physics
fitOnBounceCurveFor: aVelocity start: aStart end: anEnd
	| aDurationToApex aDistanceToApex aDistanceToEdge aSquaredVelocity aTotalDuration |
	
	"Simulate a bounce that started from edge"
	aDurationToApex := aVelocity negated / deceleration.
	aSquaredVelocity := aVelocity * aVelocity.
	aDistanceToApex := (aSquaredVelocity / 2.0) / deceleration abs.
	aDistanceToEdge := (anEnd - aStart) abs.
	
	aTotalDuration := (2.0 * (aDistanceToApex + aDistanceToEdge) / deceleration abs ) sqrt.
	
	"Update values"
	startTime := startTime - (1000 * (aTotalDuration - aDurationToApex)).
	startPosition := anEnd.
	startVelocity := deceleration negated * aTotalDuration.
	currentPosition := anEnd.