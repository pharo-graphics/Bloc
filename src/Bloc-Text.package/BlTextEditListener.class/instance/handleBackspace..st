keyboard handlers
handleBackspace: anEvent
	| aTextEditElement aText aDelta |
	
	aTextEditElement := anEvent currentTarget.
	aText := aTextEditElement text.
	
	aDelta := 0.
	aTextEditElement cursors
		select: #hasParent
		thenDo: [ :aCursor |
			aText delete: aCursor textIndex + aDelta to: aCursor textIndex + aDelta.
			aDelta := aDelta - 1.
			self moveCursorLeft: aCursor in: aTextEditElement ].

	aTextEditElement text: aText