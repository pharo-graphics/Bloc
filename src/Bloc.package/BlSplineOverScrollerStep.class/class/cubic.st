accessing
cubic
	^ cubic ifNil: [ cubic := BlSplineOverScrollerCubicStep new ]