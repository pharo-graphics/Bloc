focus - processing
processMouseDown: anEvent
	self hasFocusOwner
		ifFalse: [ ^ self ].

	(anEvent target = lastFocusOwner)
		ifTrue: [ ^ self ].

	self processBlur: lastFocusOwner.
	"don't forget to forget focused element"
	lastFocusOwner := nil