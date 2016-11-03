initialization
initialize
	super initialize.
	running := false.
	elapsedTime := 0.
	loop := 1.
	loopCount := 0.
	delay := 0.
	duration :=1.
	actionHandlers := OrderedCollection new.
	