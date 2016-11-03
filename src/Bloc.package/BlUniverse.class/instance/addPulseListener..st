pulse managing
addPulseListener: anObject
	pulseListeners add: anObject.
	announcer subscribe: BlPulseEvent send: #pulse to: anObject