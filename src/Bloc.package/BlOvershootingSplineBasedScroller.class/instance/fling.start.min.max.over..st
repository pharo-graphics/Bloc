api - scrolling
fling: aVelocity start: aStart min: aMin max: aMax over: anOvershotDistance
	
	self flag: 'refactor'.
	
	(self isBallistic and: [ aVelocity abs > self currentVelocity abs and: [ aVelocity abs <  self startVelocity abs ] ])
		ifTrue: [ ^ self ].

	(self isCubic and: [ self isFinished not and: [ self currentVelocity isZero not and: [ aVelocity sign ~~ self startVelocity sign ] ] ])
		ifTrue: [ ^ self ].
		
	self mode: (BlSplineOverScrollerFlingMode new
		velocity: aVelocity;
		startPosition: aStart;
		minPosition: aMin;
		maxPosition: aMax;
		overshotDistance: anOvershotDistance)