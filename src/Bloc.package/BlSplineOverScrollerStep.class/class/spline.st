accessing
spline
	^ spline ifNil: [ spline := BlSplineOverScrollerSplineStep new ]