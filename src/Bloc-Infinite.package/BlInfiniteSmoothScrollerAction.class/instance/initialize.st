initialization
initialize
	super initialize.
	
	deltaX := 0.
	deltaY := 0.
	duration := nil. "undefined duration"
	jumpPosition := NoPosition.
	isChanged := false.	
	consecutiveUpdates := 0.