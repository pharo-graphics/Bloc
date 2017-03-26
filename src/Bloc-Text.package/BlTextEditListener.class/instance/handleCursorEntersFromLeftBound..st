event handling
handleCursorEntersFromLeftBound: anEvent
	| aTextEditElement |

	aTextEditElement := anEvent currentTarget.
	aTextEditElement requestFocus.

	self
		addCursorAtIndex: 0
		in: aTextEditElement