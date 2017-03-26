event handling
handleCursorEntersFromRightBound: anEvent
	| aTextEditElement |

	aTextEditElement := anEvent currentTarget.
	aTextEditElement requestFocus.

	self
		addCursorAtIndex: aTextEditElement text size - 1
		in: aTextEditElement