event management
buildEventDispatchChain: aTail
	| aResultTail |
	aResultTail := aTail.
	aResultTail addFirst: self eventDispatcher.
	self nextEventSource ifNotNil: [ :next | aResultTail := next buildEventDispatchChain: aTail ].
	^ aResultTail