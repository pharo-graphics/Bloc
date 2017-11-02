mouse handlers
clickEvent: anEvent
	| aTextEditElement aClickPosition |
		
	aTextEditElement := anEvent currentTarget.
	aTextEditElement requestFocus.

	aClickPosition := aTextEditElement globalPointToLocal: anEvent position.
	self moveCursorAtPosition: aClickPosition in: aTextEditElement