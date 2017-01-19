private - event
convertEvent: aGtkEvent hostSpace: anHostSpace
	eventHandler hostSpace: anHostSpace.
	aGtkEvent accept: eventHandler