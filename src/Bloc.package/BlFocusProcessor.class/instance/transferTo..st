focus - requesting
transferTo: anElement
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not transfer focus to nil!' ].

	self hasFocusOwner
		ifFalse: [ ^ self requestFor: anElement ].

	self processTransfer: anElement.
	self processBlur: lastFocusOwner.
	"don't forget to forget focused element"
	lastFocusOwner := nil.
	self processFocus: anElement