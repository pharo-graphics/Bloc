physics
springback: aStart min: aMin max: aMax
	
	isFinished := true.
	startPosition := aStart.
	finalPosition := aStart.
	currentPosition := aStart.
	startVelocity := 0.
	
	startTime := self time now.
	duration := 0 milliSeconds.

	aStart < aMin
		ifTrue: [ self startSpringbackFor: 0 start: aStart end: aMin ]
		ifFalse: [ aStart > aMax
			ifTrue: [ self startSpringbackFor: 0 start: aStart end: aMax ] ].
		
	^ isFinished not