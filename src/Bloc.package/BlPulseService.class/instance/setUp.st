as yet unclassified
setUp
	super setUp.
	pulseEvent := BlPulseEvent new.
	lastElpasedTime := 0.
	pulseStartTime := 0.