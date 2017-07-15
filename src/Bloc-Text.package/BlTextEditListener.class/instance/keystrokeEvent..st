keyboard handlers
keystrokeEvent: anEvent
	| aTextEditElement |

	aTextEditElement := anEvent currentTarget.

	anEvent char = Character arrowLeft
		ifTrue: [ ^ self moveCursorLeft: aTextEditElement ].

	anEvent char = Character arrowRight
		ifTrue: [ ^ self moveCursorRight: aTextEditElement ].
	
	anEvent char = Character arrowUp
		ifTrue: [ ^ self moveCursorUp: aTextEditElement ].
		
	anEvent char = Character arrowDown
		ifTrue: [ ^ self moveCursorDown: aTextEditElement ].

	anEvent char = Character backspace
		ifTrue: [ ^ self handleBackspace: anEvent ].

	anEvent char = Character delete
		ifTrue: [ ^ self handleDelete: anEvent ].
		
	self handleInsert: anEvent