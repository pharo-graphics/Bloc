cursor - management
moveCursorLeft: aTextEditElement by: aNumber
	"Move cursor of a given text edit element to the left by a provided distance as a number.
	aNumber must be greater then zero"

	self
		assert: [ aTextEditElement hasCursor ]
		description: [ 'An element must have a cursor in order to move it left' ].

	self 
		assert: [ aNumber > 0 ]
		description: [ 'Cursor movement distance must be greater than zero' ].
	
	(aTextEditElement cursorPosition - aNumber) < 0
		ifTrue: [ ^ self transferCursorLeft: aTextEditElement ].

	self
		moveCursorTo: aTextEditElement cursorPosition - aNumber
		in: aTextEditElement