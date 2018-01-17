dispatching
dispatchEvent: anEvent next: aBlEventDispatcherChain
	| resultEvent |
	
	anEvent currentTarget: self owner.
	resultEvent := self dispatchCapturingEvent: anEvent.
	
	resultEvent isConsumed ifTrue: [ ^ nil ].
	resultEvent ifNil:[^ nil].
	
	(resultEvent canBePropagated)
		ifTrue: [ resultEvent := aBlEventDispatcherChain dispatchEvent: resultEvent ].
	
	resultEvent ifNil:[^ nil].
	resultEvent isConsumed ifTrue: [ ^ nil ].
	
	resultEvent currentTarget: self owner.
	resultEvent := self dispatchBubblingEvent: resultEvent.
	resultEvent isConsumed ifTrue: [ ^ nil ].
	^ resultEvent