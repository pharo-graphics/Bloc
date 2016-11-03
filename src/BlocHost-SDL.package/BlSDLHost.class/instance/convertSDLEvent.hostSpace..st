private
convertSDLEvent: anSDLEvent hostSpace: anHostSpace
	eventHandler hostSpace: anHostSpace.
	^ anSDLEvent accept: eventHandler