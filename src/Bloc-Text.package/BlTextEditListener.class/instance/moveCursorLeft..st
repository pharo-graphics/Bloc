cursor - management
moveCursorLeft: aTextEditElement
	
	self
		assert: [ aTextEditElement hasCursor ]
		description: [ 'An element must have a cursor in order to move it right' ].
	
	aTextEditElement cursor cursorPosition <= 1
		ifTrue: [ ^ self transferCursorLeft: aTextEditElement ].

	self
		moveCursorTo: aTextEditElement cursor cursorPosition - 1
		in: aTextEditElement