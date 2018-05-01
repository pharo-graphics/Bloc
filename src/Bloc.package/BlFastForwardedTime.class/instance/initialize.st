initialization
initialize
	super initialize.
	
	speed := 1.0.
	previousRealTime := DateAndTime now.
	previousSpeededUpTime := previousRealTime.