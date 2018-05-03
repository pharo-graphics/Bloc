initialization
initializeOn: aSplineOverScroller
	aSplineOverScroller isFinished: false.
	
	aSplineOverScroller startPosition: self startPosition.
	aSplineOverScroller currentPosition: self startPosition.
	aSplineOverScroller finalPosition: self startPosition + self distance.
	
	aSplineOverScroller updateTime
		ifNil: [ aSplineOverScroller startTime: aSplineOverScroller time now ]
		ifNotNil: [ aSplineOverScroller startTime: aSplineOverScroller updateTime ].

	aSplineOverScroller duration: self duration.
	
	aSplineOverScroller deceleration: 0.0.
	aSplineOverScroller startVelocity: 0