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
		| typeChanged holder |
		typeChanged := false.
		holder := aContext controller elementHolderAt: position.
		
		(holder isNotNil or: [ aContext canFindInPreLayout: position ])
			ifTrue: [ 
				type = command typeInvisible ifTrue: [ 
					self dispatchOn: aContext start: tmpStart count: tmpCount.
					typeChanged := true ].
				type := command typeNewOrLaidOut ]
			ifFalse: [ 
				type = command typeNewOrLaidOut ifTrue: [ 
					self postponeOn: aContext start: tmpStart count: tmpCount.
					typeChanged := true ].
				type := command typeInvisible ].

		typeChanged
			ifTrue: [ 
				position := position - tmpCount.
				tmpEnd := tmpEnd - tmpCount.
				tmpCount := 1 ]
			ifFalse: [ tmpCount := tmpCount + 1 ].
		position := position + 1 ].

	(tmpCount ~= command itemCount) ifTrue: [ 
		aContext recycleCommand: command.
		command := aContext createCommand: self
			positionStart: tmpStart
			itemCount: tmpCount
			payload: nil ].

	type = command typeInvisible
		ifTrue: [ aContext dispatchAndUpdateElementHolders: command ]
		ifFalse: [ aContext postponeAndUpdateElementHolders: command ]