loop process
initialize
	super initialize.
	pulseEvent := BlPulseEvent new.
	lastElpasedTime := 0.
	pulseStartTime := 0.