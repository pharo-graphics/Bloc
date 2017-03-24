cursor - management
moveCursorLeft: aCursorElement in: aTextEditElement

	aCursorElement textIndex < 1
		ifTrue: [
			^ aTextEditElement fireEvent: (
				BlTextCursorLeftBoundReached new
					cursorElement: aCursorElement;
					textElement: aTextEditElement) ].

	self
		moveCursor: aCursorElement
		to: aCursorElement textIndex - 1
		in: aTextEditElement