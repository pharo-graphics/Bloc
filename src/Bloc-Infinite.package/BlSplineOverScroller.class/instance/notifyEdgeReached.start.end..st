scrolling
notifyEdgeReached: anOvershotDistance start: aStart end: anEnd
	
	state = Spline
		ifTrue: [ 
			overshotDistance := anOvershotDistance.
			startTime := DateAndTime millisecondClockValue.
			"We were in fling/scroll mode before: current velocity is such that distance to
			edge is increasing. This ensures that startAfterEdge will not start a new fling."
			self startAfterEdgeFor: currentVelocity start: aStart min: anEnd max: anEnd ]