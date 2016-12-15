physics
springback: aStart min: aMin max: aMax
	
	isFinished := true.
	startPosition := aStart.
	finalPosition := aStart.
	currentPosition := aStart.
	startVelocity := 0.
	startTime := DateAndTime millisecondClockValue.
	duration := 0.

	aStart < aMin
		ifTrue: [ self startSpringbackFor: 0 start: aStart end: aMin ]
		ifFalse: [ aStart > aMax
			ifTrue: [ self startSpringbackFor: 0 start: aStart end: aMax ] ].
		
	^ isFinished not