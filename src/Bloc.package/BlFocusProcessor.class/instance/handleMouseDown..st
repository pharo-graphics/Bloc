focus - processing
handleMouseDown: anEvent
	self hasFocusOwner
		ifFalse: [ ^ self ].

	(anEvent target = focusOwner)
		ifTrue: [ ^ self ].

	self processBlur: focusOwner.
	"don't forget to forget focused element"
	focusOwner := nil