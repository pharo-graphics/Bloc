initialization
initialize
	super initialize.
	
	duration := 1 second.	"configurable"
	delay := 0 milliSeconds. "configurable"
	
	elapsedTime := 0 milliSeconds.
	
	loop := 1.
	loopCount := 0.
	running := false.
	
	actionHandlers := OrderedCollection new.
	eventDispatcher := BlDirectEventDispatcher on: self