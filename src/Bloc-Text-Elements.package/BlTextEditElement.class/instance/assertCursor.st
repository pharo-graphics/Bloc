asserting
assertCursor
	self
		assert: [ self text isNotEmpty or: [ self cursorPosition isZero ] ]
		description: [ 'Cursor position can only be zero if text is empty' ].
	self
		assert: [ self cursorPosition between: 0 and: self text size ]
		description: [ 'Cursor must be within text bounds (0 is allowed)' ].