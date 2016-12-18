initialization
initialize
	super initialize.
	
	interimTarget := 0@0.
	linearInterpolator := self defaultLinearInterpolator.
	decelerateInterpolator := self defaultDecelerateInterpolator