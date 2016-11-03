as yet unclassified
outside: aClient on: anEventClass sendTo: anObject
	^ (self on: anEventClass sendTo: anObject)
		client: aClient;
		yourself