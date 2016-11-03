event managing
buildEventDispatchChain: aTail
	| aResultTail |
	aResultTail := aTail.
	aResultTail addFirst: self eventDispatcher.
	self parent ifNotNil: [ :p | aResultTail := p buildEventDispatchChain: aTail ].
	^ aResultTail