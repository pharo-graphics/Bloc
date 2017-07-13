keyboard handlers
keystrokeEvent: anEvent
	| aTextEditElement aText aDelta |

	aTextEditElement := anEvent currentTarget.

	aText := aTextEditElement text.

	anEvent char = Character arrowLeft
		ifTrue: [ ^ self moveCursorsLeft: aTextEditElement ].

	anEvent char = Character arrowRight
		ifTrue: [ ^ self moveCursorsRight: aTextEditElement ].
		
	anEvent char = Character arrowUp
		ifTrue: [
			| focusFinder focusUp |
			focusFinder := BlFocusFinder new.
			focusUp := focusFinder
				nextFocus: aTextEditElement
				within: aTextEditElement space root
				along: BlFocusSearchDirectionUp new.
			focusUp ifNotNil: #requestFocus.
			^ self ].
	anEvent char = Character arrowDown
		ifTrue: [
			| focusFinder focusDown |
			focusFinder := BlFocusFinder new.
			focusDown := focusFinder
				nextFocus: aTextEditElement
				within: aTextEditElement space root
				along: BlFocusSearchDirectionDown new.
			focusDown ifNotNil: #requestFocus.
			^ self ].

	anEvent char = Character backspace
		ifTrue: [ ^ self handleBackspace: anEvent ].
		
	anEvent char = Character delete
		ifTrue: [ ^ self handleDelete: anEvent ].
	
	aDelta := 0.
	aTextEditElement cursors
		select: #hasParent
		thenDo: [ :aCursor |
			aText insertString: anEvent char asString at: aCursor textIndex + aDelta.
			aDelta := aDelta + 1.
			self moveCursorRight: aCursor in: aTextEditElement ].

	aTextEditElement text: aText