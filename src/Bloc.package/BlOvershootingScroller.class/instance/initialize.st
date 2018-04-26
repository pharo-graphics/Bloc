initialization
initialize
	super initialize.
	
	time := BlTime real.
	interpolator := self defaultInterpolator.
	scrollerX := self defaultSplineScroller time: time.
	scrollerY := self defaultSplineScroller time: time.
	isFlywheel := self defaultFlyweel.
	eventDispatcher := self defaultEventDispatcher on: self