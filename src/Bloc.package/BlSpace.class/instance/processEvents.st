pulse
processEvents
	"Process events enqueued by host space and dispatch them to the scene graph"

	self
		assert: [ self hasHostSpace ]
		description: [ 'Events can only be processed if I have a host space' ].
				
	self hostSpace fetchedEventsDo: [ :anEvent |
		self eventDispatcher dispatchEvent: anEvent ].

	self mouseProcessor generateEvents