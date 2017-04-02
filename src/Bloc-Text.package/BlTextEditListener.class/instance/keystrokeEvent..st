keyboard handlers
keystrokeEvent: anEvent
	| aTextEditElement aText aDelta |

	aTextEditElement := anEvent currentTarget.
	
	aText := aTextEditElement text.

	anEvent charCode = Character arrowLeft
		ifTrue: [ ^ self moveCursorsLeft: aTextEditElement ].

	anEvent charCode = Character arrowRight
		ifTrue: [ ^ self moveCursorsRight: aTextEditElement ].

	anEvent charCode = Character backspace
		ifTrue: [ ^ self ].
	
	aDelta := 0.
	aTextEditElement cursors
		select: #hasParent
		thenDo: [ :aCursor |
			aText insertString: anEvent charCode asString at: aCursor textIndex + aDelta.
			aTextEditElement dispatchEvent: (BrTextInsertedEvent new start: aCursor textIndex + aDelta + aText start; length: 1). 
			aDelta := aDelta + 1 ].
		
	