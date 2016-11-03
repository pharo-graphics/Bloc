pulse
processEvents

	self hostSpace ifNotNil:[:hs| 
		hs fetchedEventsDo: [ :evt | self eventDispatcher dispatchEvent: evt ]].
	self mouseProcessor generateEvents.