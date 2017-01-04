private - event
convertEvent: anSDLEvent hostSpace: anHostSpace
	eventHandler hostSpace: anHostSpace.
	^ anSDLEvent accept: eventHandler