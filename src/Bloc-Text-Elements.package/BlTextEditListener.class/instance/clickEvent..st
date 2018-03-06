mouse handlers
clickEvent: anEvent
	| aTextEditElement aClickPosition |
	anEvent consumed: true.

	aTextEditElement := anEvent currentTarget.
	aTextEditElement requestFocus.

	aClickPosition := aTextEditElement globalPointToLocal: anEvent position.
	self moveCursorAtPosition: aClickPosition in: aTextEditElement