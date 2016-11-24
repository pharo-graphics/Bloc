event management
buildEventDispatchChain: aTail
	| aResultTail |
	aResultTail := aTail.
	aResultTail addFirst: self eventDispatcher.
	self nextEventTarget ifNotNil: [ :next | aResultTail := next buildEventDispatchChain: aTail ].
	^ aResultTail