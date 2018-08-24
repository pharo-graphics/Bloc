"
I handle user events and update text model of a text edit element
"
Class {
	#name : #BlTextEditListener,
	#superclass : #BlBasicTextEditListener,
	#category : 'Bloc-Text-Elements'
}

{ #category : #'focus handlers' }
BlTextEditListener >> blurEvent: anEvent [
	super blurEvent: anEvent.
	
	anEvent currentTarget hideCursor
]

{ #category : #'mouse handlers' }
BlTextEditListener >> clickEvent: anEvent [
	| aTextEditElement aClickPosition |
	anEvent consumed: true.

	aTextEditElement := anEvent currentTarget.
	aTextEditElement requestFocus.

	aClickPosition := aTextEditElement globalPointToLocal: anEvent position.
	self moveCursorAtPosition: aClickPosition in: aTextEditElement
]

{ #category : #'text - modifications' }
BlTextEditListener >> deleteAt: aTextIndex in: aTextEditElement [
	| aText |

	aText := aTextEditElement text.

	aText
		delete: aTextIndex
		to: aTextIndex.

	aTextEditElement textChanged.

	self
		moveCursorTo: ((aTextIndex - 1) max: 0)
		in: aTextEditElement
]

{ #category : #'focus handlers' }
BlTextEditListener >> focusEvent: anEvent [
	super focusEvent: anEvent.

	anEvent currentTarget
		showCursor
]

{ #category : #'focus handlers' }
BlTextEditListener >> focusTransferEvent: anEvent [
	| aTransferBounds aTransferPosition aTextEditElement |
	super focusTransferEvent: anEvent.

	aTextEditElement := anEvent currentTarget.

	aTransferBounds := anEvent transfer localBoundsToGlobal: (anEvent transfer focusedBounds: BlBounds new).
	aTransferPosition := aTextEditElement globalPointToLocal: aTransferBounds center.

	self
		moveCursorAtPosition: aTransferPosition
		in: aTextEditElement
]

{ #category : #'keyboard handlers' }
BlTextEditListener >> handleBackspace: anEvent [
	
	self
		deleteAt: anEvent currentTarget cursorPosition
		in: anEvent currentTarget
]

{ #category : #'keyboard handlers' }
BlTextEditListener >> handleDelete: anEvent [
	
	self
		deleteAt: anEvent currentTarget cursorPosition + 1
		in: anEvent currentTarget
]

{ #category : #'keyboard handlers' }
BlTextEditListener >> handleInsert: anEvent [
	
	self
		insertString: anEvent char asString
		at: anEvent currentTarget cursorPosition
		in: anEvent currentTarget
]

{ #category : #'text - modifications' }
BlTextEditListener >> insertString: aString at: aTextIndex in: aTextEditElement [
	"Insert a given string in a provided text edit element.
	The exact location of an inserted string is determined by current cursor location"
	| aText |

	aText := aTextEditElement text.

	aText
		insertString: aString
		at: aTextIndex.

	aTextEditElement textChanged.

	self
		moveCursorRight: aTextEditElement
		by: aString size
]

{ #category : #'keyboard handlers' }
BlTextEditListener >> keystrokeEvent: anEvent [
	| aTextEditElement |

	aTextEditElement := anEvent currentTarget.

	anEvent char = Character arrowLeft
		ifTrue: [ ^ self "moveCursorLeft: aTextEditElement" ].

	anEvent char = Character arrowRight
		ifTrue: [ ^ self "moveCursorRight: aTextEditElement" ].
	
	anEvent char = Character arrowUp
		ifTrue: [ ^ self moveCursorUp: aTextEditElement ].
		
	anEvent char = Character arrowDown
		ifTrue: [ ^ self moveCursorDown: aTextEditElement ].

	anEvent char = Character backspace
		ifTrue: [ ^ self handleBackspace: anEvent ].

	anEvent char = Character delete
		ifTrue: [ ^ self handleDelete: anEvent ].
		
	self handleInsert: anEvent
]

{ #category : #'cursor - management' }
BlTextEditListener >> moveCursorAtPosition: aPoint in: aTextEditElement [
	| aTextIndex |

	aTextIndex := aTextEditElement paragraph indexAtPosition: aPoint.
	self
		moveCursorTo: aTextIndex
		in: aTextEditElement
]

{ #category : #'cursor - management' }
BlTextEditListener >> moveCursorDown: anElement [
	| focusFinder focusDown |
	
	focusFinder := BlFocusFinder new.
	focusDown := focusFinder
		nextFocus: anElement
		within: anElement space root
		along: BlFocusSearchDirectionDown new.
	focusDown ifNotNil: #transferFocus
]

{ #category : #'cursor - management' }
BlTextEditListener >> moveCursorLeft: aTextEditElement [
	
	self
		moveCursorLeft: aTextEditElement 
		by: 1
]

{ #category : #'cursor - management' }
BlTextEditListener >> moveCursorLeft: aTextEditElement by: aNumber [
	"Move cursor of a given text edit element to the left by a provided distance as a number.
	aNumber must be greater then zero"

	self
		assert: [ aTextEditElement hasCursor ]
		description: [ 'An element must have a cursor in order to move it left' ].

	self 
		assert: [ aNumber > 0 ]
		description: [ 'Cursor movement distance must be greater than zero' ].
	
	(aTextEditElement cursorPosition - aNumber) < 0
		ifTrue: [ ^ self transferCursorLeft: aTextEditElement ].

	self
		moveCursorTo: aTextEditElement cursorPosition - aNumber
		in: aTextEditElement
]

{ #category : #'cursor - management' }
BlTextEditListener >> moveCursorRight: aTextEditElement [
	
	self
		moveCursorRight: aTextEditElement 
		by: 1
]

{ #category : #'cursor - management' }
BlTextEditListener >> moveCursorRight: aTextEditElement by: aNumber [
	"Move cursor of a given text edit element to the right by a provided distance as a number.
	aNumber must be greater then zero"

	self
		assert: [ aTextEditElement hasCursor ]
		description: [ 'An element must have a cursor in order to move it right' ].

	self 
		assert: [ aNumber > 0 ]
		description: [ 'Cursor movement distance must be greater than zero' ].
	
	(aTextEditElement cursorPosition + aNumber) > (aTextEditElement text size)
		ifTrue: [ ^ self transferCursorRight: aTextEditElement ].

	self
		moveCursorTo: aTextEditElement cursorPosition + aNumber
		in: aTextEditElement
]

{ #category : #'cursor - management' }
BlTextEditListener >> moveCursorTo: aTextIndex in: aTextElement [
	
	self
		assert: [ aTextIndex >= 0 ]
		description: [ 'Text index must not be negative' ].
		
	self
		assert: [ aTextIndex <= aTextElement text size ]
		description: [ 'Text index must be within text size' ].

	aTextElement showCursorAt: aTextIndex
]

{ #category : #'cursor - management' }
BlTextEditListener >> moveCursorUp: anElement [
	| focusFinder focusUp |
	
	focusFinder := BlFocusFinder new.
	focusUp := focusFinder
		nextFocus: anElement
		within: anElement space root
		along: BlFocusSearchDirectionUp new.
	focusUp ifNotNil: #transferFocus
]

{ #category : #'selection handlers' }
BlTextEditListener >> select: aFromIndex to: aToIndex in: aTextEditElement [
	aTextEditElement selectSet: aFromIndex to: aToIndex
]

{ #category : #'selection handlers' }
BlTextEditListener >> selectNone: aTextEditElement [
	aTextEditElement selectNone
]

{ #category : #'selection handlers' }
BlTextEditListener >> selectionAcquiredEvent: anEvent [
	| aTextEditElement |
	anEvent consumed: true.
		
	aTextEditElement := anEvent currentTarget.
	
	(anEvent bounds = aTextEditElement boundsInLocal)
		ifTrue: [
			self
				select: 0
				to: aTextEditElement text size
				in: aTextEditElement ]
		ifFalse: [ 
			| aFromIndex aToIndex |
			aFromIndex := aTextEditElement paragraph indexAtPosition: anEvent bounds origin.
			aToIndex := aTextEditElement paragraph indexAtPosition: anEvent bounds corner.

			self select: aFromIndex to: aToIndex in: aTextEditElement ]
]

{ #category : #'selection handlers' }
BlTextEditListener >> selectionLostEvent: anEvent [
	super selectionLostEvent: anEvent.
	
	self selectNone: anEvent currentTarget
]

{ #category : #'cursor - management' }
BlTextEditListener >> transferCursorLeft: anElement [
	| focusFinder focusLeft |

	focusFinder := BlFocusFinder new.
	focusLeft := focusFinder
		nextFocus: anElement
		within: anElement space root
		along: BlFocusSearchDirectionLeft new.
	focusLeft ifNotNil: #transferFocus
]

{ #category : #'cursor - management' }
BlTextEditListener >> transferCursorRight: anElement [
	| focusFinder focusRight |

	focusFinder := BlFocusFinder new.
	focusRight := focusFinder
		nextFocus: anElement
		within: anElement space root
		along: BlFocusSearchDirectionRight new.
	focusRight ifNotNil: #transferFocus
]
