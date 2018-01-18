event management
dispatchEvent: anEvent
	"I only call my event dispatcher, so the event can be only handled by my event handlers/filters"
	
	anEvent forwardingTarget: self.
	(self eventDispatcher wantsEvent: anEvent)
		ifTrue: [ self eventDispatcher dispatchEvent: anEvent ]