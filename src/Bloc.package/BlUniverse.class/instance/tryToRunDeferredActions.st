pulse managing
tryToRunDeferredActions
	| nextInQueue |
	[ self pulseLoop timeIsUp not and: [ (nextInQueue := deferredActions nextOrNil) isNotNil ] ]
		whileTrue: [ nextInQueue value ].
	deferredActions isEmpty ifFalse: [ self requestNextPulse ]