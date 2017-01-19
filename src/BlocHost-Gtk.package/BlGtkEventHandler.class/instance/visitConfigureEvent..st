accessing
visitConfigureEvent: aGdkEvent
	| evtResize evtMove|
	evtResize := BlSpaceResizeEvent new 
		extent: aGdkEvent width @ aGdkEvent height;
		timestamp: Time millisecondClockValue.
	
	"evtMove := BlSpaceMoveEvent new 
		position:  aGdkEvent x @ aGdkEvent y;
		timestamp: Time millisecondClockValue."
		
	self hostSpace enqueueEvent: evtResize.
	"self hostSpace enqueueEvent: evtMove"