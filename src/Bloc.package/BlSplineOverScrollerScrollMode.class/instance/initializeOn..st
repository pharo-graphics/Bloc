initialization
initializeOn: aSplineOverScroller
	aSplineOverScroller isFinished: false.
	
	aSplineOverScroller startPosition: self startPosition.
	aSplineOverScroller currentPosition: self startPosition.
	aSplineOverScroller finalPosition: self startPosition + self distance.
	
	aSplineOverScroller startTime: aSplineOverScroller time now.
	aSplineOverScroller duration: self duration.
	
	aSplineOverScroller deceleration: 0.0.
	aSplineOverScroller startVelocity: 0