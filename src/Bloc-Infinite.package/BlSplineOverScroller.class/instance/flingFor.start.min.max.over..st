physics
flingFor: aVelocity start: aStart min: aMin max: aMax over: anOvershotDistance
	| aTotalDistance |
	
	overshotDistance := anOvershotDistance.
	isFinished := false.
	self currentVelocity: aVelocity.
	startVelocity := aVelocity.
	splineDuration := 0.
	duration := 0.
	startTime := DateAndTime millisecondClockValue.
	startPosition := aStart.
	currentPosition := aStart.
	
	(aStart > aMax or: [ aStart < aMin ])
		ifTrue: [ ^ self startAfterEdgeFor: aVelocity start: aStart min: aMin max: aMax ].

	state := Spline.
	aTotalDistance := 0.
	
	"almost zero"
	(aVelocity abs < 0.001)
		ifFalse: [ 
			splineDuration := self splineFlingDurationFor: aVelocity.
			duration := splineDuration.
			aTotalDistance := self splineFlingDistanceFor: aVelocity ].
	
	splineDistance := aTotalDistance * aVelocity sign.
	finalPosition := aStart + splineDistance.

	"Clamp to a valid final position"
	finalPosition < aMin
		ifTrue: [ 
			self adjustDuration: aStart final: aMin previousFinal: finalPosition.
			finalPosition := aMin ].
	
	finalPosition > aMax
		ifTrue: [ 
			self adjustDuration: aStart final: aMax previousFinal: finalPosition.
			finalPosition := aMax ]