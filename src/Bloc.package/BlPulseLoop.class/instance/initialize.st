initialization
initialize
	super initialize.
	pulseEvent := BlPulseEvent new.
	lastElpasedTime := 0.
	pulseStartTime := DateAndTime now.