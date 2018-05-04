initialization
initialize
	super initialize.
	
	time := BlTime real.
	
	self registerGesture: OSTouchTwoFingersScrollDetector new.
	self registerGesture: OSTouchTwoFingersPinchDetector new.