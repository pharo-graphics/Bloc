dispatch
apply: aCommand on: aContext
	| command tmpStart tmpCount tmpEnd type position |
	command := aCommand.
	tmpStart := command positionStart.
	tmpCount := 0.
	tmpEnd := command positionStart + command itemCount.
	type := -1.

	position := command positionStart.
	[ position < tmpEnd ]  whileTrue: [
		| holder |
		holder := aContext controller elementHolderAt: position.
		
		(holder isNotNil or: [ aContext canFindInPreLayout: position ])
			ifTrue: [ 
				type = command typeInvisible ifTrue: [ 
					self dispatchOn: aContext start: tmpStart count: tmpCount payload: command payload.
					tmpCount := 0.
					tmpStart := position ].
				type := command typeNewOrLaidOut ]
			ifFalse: [ 
				type = command typeNewOrLaidOut ifTrue: [ 
					self postponeOn: aContext start: tmpStart count: tmpCount payload: command payload.
					tmpCount := 0.
					tmpStart := position ].
				type := command typeInvisible ].

		tmpCount := tmpCount + 1.
		position := position + 1 ].
	
	(tmpCount ~= command itemCount) ifTrue: [ 
		|aPayload|
		aPayload := command payload.
		aContext recycleCommand: command.
		command := aContext createCommand: self
			positionStart: tmpStart
			itemCount: tmpCount
			payload: aPayload ].

	type = command typeInvisible
		ifTrue: [ aContext dispatchAndUpdateElementHolders: command ]
		ifFalse: [ aContext postponeAndUpdateElementHolders: command ]