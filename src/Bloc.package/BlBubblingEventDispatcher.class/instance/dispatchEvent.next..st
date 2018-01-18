dispatching
dispatchEvent: anEvent next: aBlEventDispatcherChain
	<return: #BlEvent>
	
	anEvent isConsumed
		ifTrue: [ ^ anEvent ].
		
	self dispatchCapturingEvent: anEvent.

	anEvent isConsumed
		ifTrue: [ ^ anEvent ].	

	anEvent canBePropagated
		ifTrue: [ aBlEventDispatcherChain dispatchEvent: anEvent ].

	anEvent isConsumed
		ifTrue: [ ^ anEvent ].

	self owner == anEvent target
		ifTrue: [ self dispatchArrivedEvent: anEvent ]
		ifFalse: [ self dispatchBubblingEvent: anEvent ].

	^ anEvent