initialization
initialize
	super initialize.
	
	requestingLayout := true.
	waitingLayout := true.
	measuredExtent := 0@0.
	direction := self defaultDirection.