pulse managing
removePulseListener: anObject
	pulseListeners remove: anObject.
	announcer unsubscribe: anObject.
	pulseListeners isEmpty
		ifTrue: [ self stop ]