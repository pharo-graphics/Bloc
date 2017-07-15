keyboard handlers
handleInsert: anEvent
	| aTextEditElement aText |

	aTextEditElement := anEvent currentTarget.
	aText := aTextEditElement text.

	aText insertString: anEvent char asString at: aTextEditElement cursor textIndex.
	self moveCursorRight: aTextEditElement.
	aTextEditElement text: aText