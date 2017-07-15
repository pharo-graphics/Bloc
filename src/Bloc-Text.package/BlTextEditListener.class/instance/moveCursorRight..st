cursor - management
moveCursorRight: aTextEditElement
	
	self
		assert: [ aTextEditElement hasCursor ]
		description: [ 'An element must have a cursor in order to move it right' ].
	
	aTextEditElement cursor textIndex >= (aTextEditElement text size)
		ifTrue: [ ^ self transferCursorRight: aTextEditElement ].

	self
		moveCursorTo: aTextEditElement cursor textIndex + 1
		in: aTextEditElement