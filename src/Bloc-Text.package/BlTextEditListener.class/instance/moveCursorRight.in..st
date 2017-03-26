cursor - management
moveCursorRight: aCursorElement in: aTextEditElement

	aCursorElement textIndex >= (aTextEditElement text size - 1)
		ifTrue: [
			^ aTextEditElement fireEvent: (
				BlTextCursorRightBoundReached new
					cursorElement: aCursorElement;
					textElement: aTextEditElement) ].

	self
		moveCursor: aCursorElement
		to: aCursorElement textIndex + 1
		in: aTextEditElement