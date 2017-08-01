cursor - management
moveCursorRight: aTextEditElement by: aNumber
	"Move cursor of a given text edit element to the right by a provided distance as a number.
	aNumber must be greater then zero"

	self
		assert: [ aTextEditElement hasCursor ]
		description: [ 'An element must have a cursor in order to move it right' ].

	self 
		assert: [ aNumber > 0 ]
		description: [ 'Cursor movement distance must be greater than zero' ].
	
	(aTextEditElement cursor cursorPosition + aNumber) > (aTextEditElement text size)
		ifTrue: [ ^ self transferCursorRight: aTextEditElement ].

	self
		moveCursorTo: aTextEditElement cursor cursorPosition + aNumber
		in: aTextEditElement