focus request
processMouseDown: anEvent

	(lastFocusOwner isNotNil and:[(anEvent target = lastFocusOwner) not]) ifTrue: [ 
		self processBlur:(BlBaseFocusEvent new
			target: lastFocusOwner;
			yourself).
		lastFocusOwner := nil 
	]