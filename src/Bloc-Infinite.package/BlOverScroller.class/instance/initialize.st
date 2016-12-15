initialization
initialize
	super initialize.
	
	interpolator := self defaultInterpolator.
	scrollerX := self defaultSplineScroller.
	scrollerY := self defaultSplineScroller.
	isFlywheel := self defaultFlyweel