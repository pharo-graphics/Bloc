scrolling
notifyEdgeReached: anOvershotDistance start: aStart end: anEnd
	
	currentStep = Spline
		ifTrue: [ 
			overshotDistance := anOvershotDistance.
			startTime := self time now.
			"We were in fling/scroll mode before: current velocity is such that distance to
			edge is increasing. This ensures that startAfterEdge will not start a new fling."
			self startAfterEdgeFor: currentVelocity start: aStart min: anEnd max: anEnd ]