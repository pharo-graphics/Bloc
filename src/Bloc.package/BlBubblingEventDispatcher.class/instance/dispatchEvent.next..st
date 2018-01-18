dispatching
dispatchEvent: anEvent next: aBlEventDispatcherChain
	| resultEvent |

	anEvent currentTarget: self owner from: self.
	resultEvent := anEvent.
	resultEvent := self dispatchCapturingEvent: resultEvent.

	resultEvent isConsumed
		ifTrue: [ ^ resultEvent ].

	(resultEvent canBePropagated)
		ifTrue: [ resultEvent := aBlEventDispatcherChain dispatchEvent: resultEvent ].

	resultEvent isConsumed
		ifTrue: [ ^ resultEvent ].

	resultEvent currentTarget: self owner from: self.
	resultEvent := self dispatchBubblingEvent: resultEvent.

	^ resultEvent