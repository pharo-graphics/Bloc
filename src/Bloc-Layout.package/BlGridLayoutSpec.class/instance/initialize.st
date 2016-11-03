initialization
initialize
	super initialize.
	
	startDefined := false.
	span := Interval from: UNDEFINED to: UNDEFINED + 1. 
	weight := 0.
	alignment := BlGridAlignment undefined