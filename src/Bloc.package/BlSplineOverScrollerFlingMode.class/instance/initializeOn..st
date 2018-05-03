initialization
initializeOn: aSplineOverScroller
	| aTotalDistance |
		
	aSplineOverScroller overshotDistance: self overshotDistance.
	aSplineOverScroller isFinished: false.

	aSplineOverScroller startPosition: self startPosition.
	aSplineOverScroller startVelocity: self velocity.
	
	
	
	aSplineOverScroller updateTime
		ifNil: [ aSplineOverScroller startTime: aSplineOverScroller time now ]
		ifNotNil: [ aSplineOverScroller startTime: aSplineOverScroller updateTime ].
	
	"aSplineOverScroller startTime = aSplineOverScroller updateTime
		ifFalse: [ aSplineOverScroller startTime: aSplineOverScroller time now ]."
		
	"self velocity isZero ifFalse: [
		{
		#start -> aSplineOverScroller startTime.
		#update -> aSplineOverScroller updateTime.
		#now -> aSplineOverScroller time now } asDictionary logCr ]."

	aSplineOverScroller currentPosition: self startPosition.
	aSplineOverScroller currentVelocity: self velocity.
	
	aSplineOverScroller duration: 0 milliSeconds.
	aSplineOverScroller splineDuration: 0 milliSeconds.
	
	(self startPosition > self maxPosition or: [ self startPosition < self minPosition ])
		ifTrue: [
			^ aSplineOverScroller
				startAfterEdgeFor: self velocity
				start: self startPosition
				min: self minPosition
				max: self maxPosition ].

	aSplineOverScroller switchToSpline.
	aTotalDistance := 0.
	
	"almost zero"
	(self velocity abs < 0.001)
		ifFalse: [ 
			| aSplineDuration |
			
			aSplineDuration := aSplineOverScroller splineFlingDurationFor: self velocity.

			aSplineOverScroller duration: aSplineDuration.
			aSplineOverScroller splineDuration: aSplineDuration.
			
			aTotalDistance := aSplineOverScroller splineFlingDistanceFor: self velocity ].
	
	"spline distance must be a truncated integer to prevent fractional movements"
	aSplineOverScroller splineDistance: (aSplineOverScroller truncated: (aTotalDistance * self velocity sign)).
	aSplineOverScroller finalPosition: self startPosition + aSplineOverScroller splineDistance.

	"Clamp to a valid final position"
	aSplineOverScroller finalPosition < self minPosition
		ifTrue: [ 
			aSplineOverScroller duration: (aSplineOverScroller
				adjustDuration: aSplineOverScroller duration
				start: self startPosition final: self minPosition
				previousFinal: aSplineOverScroller finalPosition).
			aSplineOverScroller finalPosition: self minPosition ].
	
	aSplineOverScroller finalPosition > self maxPosition
		ifTrue: [ 
			aSplineOverScroller duration: (aSplineOverScroller
				adjustDuration: aSplineOverScroller duration
				start: self startPosition final: self maxPosition
				previousFinal: aSplineOverScroller finalPosition).
			aSplineOverScroller finalPosition: self maxPosition ]