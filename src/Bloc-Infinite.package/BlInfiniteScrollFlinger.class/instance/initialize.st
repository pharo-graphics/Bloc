initialization
initialize
	super initialize.
	
	lastFlingX := 0.
	lastFlingY := 0.
	interpolator := self defaultInterpolator.
	scroller := self createScrollerFor: interpolator.
	eatRunOnAnimationRequest := false.
	reSchedulePostAnimationCallback := false