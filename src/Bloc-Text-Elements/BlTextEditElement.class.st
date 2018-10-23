"
I am a very simple editable text element with support of a cursor.
I do not support any kind of selection or shortcuts.

My main responsibility is to handle keystrokes, update text model and support cursor movements
"
Class {
	#name : #BlTextEditElement,
	#superclass : #BlTextElement,
	#instVars : [
		'editListener',
		'cursorElements',
		'cursorStencil'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #'cursor - management' }
BlTextEditElement >> addCursorAt: aTextPosition [
	<return: #BlCursorElement>
		
	^ self
		cursorAt: aTextPosition
		ifFound: #yourself
		ifNone: [
			| aCursorElement |
			aCursorElement := self newCursor.
			aCursorElement textPosition: aTextPosition.
			cursorElements add: aCursorElement.
			self addChild: aCursorElement.
			aCursorElement ]
]

{ #category : #asserting }
BlTextEditElement >> assertCursor: aCursorElement [
	self
		assert: [ self text isNotEmpty or: [ aCursorElement textPosition isZero ] ]
		description: [ 'Cursor position can only be zero if text is empty' ].
	self
		assert: [ aCursorElement textPosition between: 0 and: self text size ]
		description: [ 'Cursor must be within text bounds (0 is allowed)' ].
]

{ #category : #private }
BlTextEditElement >> cursorAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [

	^ cursorElements
		detect: [ :aCursor | aCursor textPosition = aTextPosition ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
BlTextEditElement >> cursorElements [
	<return: #Collection of: #BlCursorElement>

	^ cursorElements
]

{ #category : #accessing }
BlTextEditElement >> cursorStencil [
	^ cursorStencil
]

{ #category : #accessing }
BlTextEditElement >> cursorStencil: aStencil [
	cursorStencil := aStencil
]

{ #category : #controller }
BlTextEditElement >> editListener [
	"Return my current edit listener.
	Note: I never return nil, so users should first check #hasEditListener before
	asking for it, otherwise behaviour is undefined"
	<return: #BlBasicTextEditListener>
	self
		assert: [ editListener isNotNil ]
		description: [ 'Edit listener can not be nil' ].

	^ editListener
]

{ #category : #controller }
BlTextEditElement >> editListener: aBlTextEditListener [
	"Set or change my edit listener.
	Note: there can be only one text edit listener assigned at a time,
	however nothing stops users from adding multiple event handler through
	a general even handler mechanism. One can even add more text edit listeners,
	however users would have to manage their change / replacement manually.
	New text edir listener must not be nil"
	self
		assert: [ aBlTextEditListener isNotNil ]
		description: [ 'Text edit listener must not be nil' ].
	
	self hasEditListener
		ifTrue: [ self removeEventHandler: self editListener ].
		
	editListener := aBlTextEditListener.
	self addEventHandler: aBlTextEditListener
]

{ #category : #'geometry bounds' }
BlTextEditElement >> focusedBounds: aBlBounds [
	"My focused bounds should be focused bounds of a cursor if it exists or my own otherwise"
	<return: #BlBounds>

	^ super focusedBounds: aBlBounds

	"^ (self cursorExists and: [ self hasFocus ])
		ifFalse: [ super focusedBounds: aBlBounds ]
		ifTrue: [ self cursorElement localBoundsToParent: (self cursorElement focusedBounds: aBlBounds) ]"
]

{ #category : #testing }
BlTextEditElement >> hasCursorAt: aTextPosition [
	"Return true if cursor at a given position exists"
	<return: #Boolean>
		
	^ self
		cursorAt: aTextPosition
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #controller }
BlTextEditElement >> hasEditListener [
	"Return true if I have an edit listener, false otherwise"
	<return: #Boolean>

	^ editListener isNotNil
]

{ #category : #'cursor - management' }
BlTextEditElement >> hideCursors [
	self cursorElements do: [ :aCursorElement | aCursorElement visibility: BlVisibility gone ]
]

{ #category : #initialization }
BlTextEditElement >> initialize [
	super initialize.

	cursorElements := OrderedCollection new.
	cursorStencil := BlCursorStencil uniqueInstance
]

{ #category : #layout }
BlTextEditElement >> measureCursors: anExtentMeasurementSpec [
	| aMaxCursorExtent |
	
	cursorElements do: [ :aCursorElement |
		| aCursorPosition aTextPosition |
		
		self assertCursor: aCursorElement.
		aCursorPosition := aCursorElement textPosition.

		"cursor is not within paragraph"
		self paragraph measuredEnd < aCursorPosition
			ifTrue: [ ^ self ].

		aTextPosition := self paragraph positionAt: aCursorPosition.
		aTextPosition := (aTextPosition x - (aCursorElement measuredWidth // 2)) @ 0.
		aCursorElement measuredBounds position: aTextPosition ].

	aMaxCursorExtent := 0@0.
	cursorElements do: [ :aCursorElement | aMaxCursorExtent := aMaxCursorExtent max: aCursorElement measuredExtent ].
	self measuredExtent: (self measuredExtent max: aMaxCursorExtent)
]

{ #category : #initialization }
BlTextEditElement >> newCursor [
	"Create and return a new instance of a cursor element"
	<return: #BlElement>

	^ self cursorStencil asElement
]

{ #category : #layout }
BlTextEditElement >> onMeasure: anExtentMeasurementSpec [	
	super onMeasure: anExtentMeasurementSpec.
	
	self measureCursors: anExtentMeasurementSpec
]

{ #category : #'cursor - management' }
BlTextEditElement >> removeCursorAt: aTextIndex [
	"Remove cursor at a goven position"

	^ self
		cursorAt: aTextIndex
		ifFound: [ :aCursorElement |
			cursorElements remove: aCursorElement.
			aCursorElement removeFromParent.
			aCursorElement ]
		ifNone: [ self error: 'Cursor at ', aTextIndex asString, ' does not exist' ]
]

{ #category : #'cursor - management' }
BlTextEditElement >> showCursors [
	self cursorElements do: [ :aCursorElement | aCursorElement visibility: BlVisibility visible ]
]
