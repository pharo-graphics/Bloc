api - recording
record: anEvent
	| aCopiedEvent |
	
	aCopiedEvent := anEvent copy.
	"we set our own timestamp to be able to differentiate what events were fetched within the same pulse (frame)"
	aCopiedEvent timestamp: pulseTimestamp.

	self events add: aCopiedEvent