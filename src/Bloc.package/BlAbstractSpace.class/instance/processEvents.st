pulse
processEvents

	self hostWindow fetchedEventsDo: [ :evt | self eventDispatcher dispatchEvent: evt ].
	self mouseProcessor generateEvents.