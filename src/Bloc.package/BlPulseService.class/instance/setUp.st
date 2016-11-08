as yet unclassified
setUp
	super setUp.
	pulseEvent := BlPulseEvent new.
	session := Smalltalk session.
	lastElpasedTime := 0.
	pulseStartTime := 0.