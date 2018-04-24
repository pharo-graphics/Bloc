initialization
initialize
	super initialize.

	time := BlTime real.
	
	currentPosition := 0.0.
	currentVelocity := 0.0.
	currentStep := Spline.
	mode := BlSplineOverScrollerNoneMode new.
	
	splineDistance := 0.0.
	splineDuration := 0 milliSeconds.

	friction := 0.015.
	deceleration := 0.0.
	ppi := 96.0.
	shouldRound := true.
	
	isFinished := true.