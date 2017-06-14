pulse
processEvents

	self hostSpace ifNotNil: [ :aHostSpace | 
		aHostSpace fetchedEventsDo: [ :anEvent |
			self eventDispatcher dispatchEvent: anEvent ] ].

	self mouseProcessor generateEvents