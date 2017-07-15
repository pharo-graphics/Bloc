focus - processing
processTransfer: anElement
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not give focus to nil' ].
	self
		assert: [ anElement ~= lastFocusOwner ]
		description: [ 'Can not give focus to the already focused element' ].
	self
		assert: [ self hasFocusOwner ]
		description: [ 'Can not transfer focus from non-focused element' ].

	self fireFocusTransferEvent: anElement from: lastFocusOwner