api - scrolling
startScrollBy: aDistance from: aStartPosition during: aDuration interpolator: anInterpolator
	
	self mode: (BlSplineOverScrollerScrollMode new
		distance: aDistance;
		startPosition: aStartPosition;
		duration: aDuration;
		interpolator: anInterpolator)