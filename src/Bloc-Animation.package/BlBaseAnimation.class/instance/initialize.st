initialization
initialize
	super initialize.
	
	duration := 1 second.	"configurable"
	delay := 0 milliSeconds. "configurable"
	loop := 1. "configurable"
	
	time := BlTime real.
	elapsedTime := 0 milliSeconds.
	progress := 0.0.
	loopCount := 0.
	isRunning := false.
	isStarted := false.
	
	actionHandlers := OrderedCollection new.
	eventDispatcher := BlDirectEventDispatcher on: self