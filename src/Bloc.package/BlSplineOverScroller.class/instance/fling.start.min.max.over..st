api - scrolling
fling: aVelocity start: aStart min: aMin max: aMax over: anOvershotDistance

	self mode: (BlSplineOverScrollerFlingMode new
		velocity: aVelocity;
		startPosition: aStart;
		minPosition: aMin;
		maxPosition: aMax;
		overshotDistance: anOvershotDistance)