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
		'cursorElement',
		'cursorPosition'
	],
	#category : 'Bloc-Text-Elements'
}

{ #category : #example }
BlTextEditElement class >> exampleText [
	| space text textElement |

	text := BlRopedText rope: (BlCollectionRope collection: (String loremIpsum: 30)).
	text attributes: { BrFontWeightAttribute bold }.

	textElement := self new.
	textElement editListener: BlTextEditListener new.
	textElement addEventHandler: BlSelectionHandler new.
	textElement relocate: 50@50.
	textElement text: text.
	textElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent. ].
	textElement background: Color veryVeryLightGray.

	space := BlSpace new.
	space root addChild: textElement.
	space show.

	^ textElement
]

{ #category : #asserting }
BlTextEditElement >> assertCursor [
	self
		assert: [ self text isNotEmpty or: [ self cursorPosition isZero ] ]
		description: [ 'Cursor position can only be zero if text is empty' ].
	self
		assert: [ self cursorPosition between: 0 and: self text size ]
		description: [ 'Cursor must be within text bounds (0 is allowed)' ].
]

{ #category : #'cursor - management' }
BlTextEditElement >> cursorElement [
	"Return an element representing a cursor"
	<return: #BlTextCursorElement>
	
	self
		assert: [ self cursorExists ]
		description: [ 'Can not access cursor if it does not exist' ].

	^ cursorElement
]

{ #category : #'cursor - management' }
BlTextEditElement >> cursorElement: anElement [
	| shouldShowCursor |
	"Change a cursor element to a given one"
	
	shouldShowCursor := self hasCursor.

	"remove existing cursor"
	self hideCursor.
	cursorElement := anElement.
	
	"and show a new one if was already visible"
	shouldShowCursor ifTrue: [ self showCursorAt: self cursorPosition ]
]

{ #category : #testing }
BlTextEditElement >> cursorExists [
	"Return true if cursor already exists (text edit element showed cursor at least once)"
	<return: #Boolean>

	^ cursorElement isNotNil
]

{ #category : #'cursor - management' }
BlTextEditElement >> cursorPosition [
	"Return a cursor position within a text"
	<return: #Number>

	^ cursorPosition
]

{ #category : #initialization }
BlTextEditElement >> defaultCursor [
	"Create and return a new instance of a cursor element"
	<return: #BlElement>

	^ BlCursorElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal exact: 1.
			c vertical matchParent ];
		background: Color black
]

{ #category : #controller }
BlTextEditElement >> editListener [
	"Return my current edit listener.
	Note: I never return nil, so users should first check #hasEditListener before
	asking for it, otherwise behaviour is undefined"
	<return: #BlTextEditListener>
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

	^ (self cursorExists and: [ self hasFocus ])
		ifFalse: [ super focusedBounds: aBlBounds ]
		ifTrue: [ self cursorElement localBoundsToParent: (self cursorElement focusedBounds: aBlBounds) ]
]

{ #category : #testing }
BlTextEditElement >> hasCursor [
	"Return true if cursor exists and visible"
	<return: #Boolean>

	^ self cursorExists and: [ cursorElement hasParent ]
]

{ #category : #controller }
BlTextEditElement >> hasEditListener [
	"Return true if I have an edit listener, false otherwise"
	<return: #Boolean>

	^ editListener isNotNil
]

{ #category : #'cursor - management' }
BlTextEditElement >> hideCursor [
	"hide all cursors"

	self hasCursor
		ifFalse: [ ^ self ].

	self removeChild: self cursorElement
]

{ #category : #initialization }
BlTextEditElement >> initialize [
	super initialize.
	
	cursorElement := nil. "initialized lazyly"
	cursorPosition := 0
]

{ #category : #layout }
BlTextEditElement >> measureCursor: anExtentMeasurementSpec [
	| aCursorElement aCursorPosition aTextPosition |
	
	self hasCursor
		ifFalse: [ ^ self ].
		
	self assertCursor.

	aCursorElement := self cursorElement.
	aCursorPosition := self cursorPosition.

	"cursor is not within paragraph"
	self paragraph measuredEnd < aCursorPosition
		ifTrue: [ ^ self ].

	aTextPosition := self paragraph positionAt: aCursorPosition.
	aTextPosition := (aTextPosition x - (aCursorElement measuredWidth // 2)) @ 0.
	aCursorElement measuredBounds position: aTextPosition.

	self measuredExtent: (self measuredExtent max: self cursorElement measuredExtent)
]

{ #category : #layout }
BlTextEditElement >> onMeasure: anExtentMeasurementSpec [	
	super onMeasure: anExtentMeasurementSpec.
	
	self measureCursor: anExtentMeasurementSpec
]

{ #category : #'cursor - management' }
BlTextEditElement >> showCursor [
	"Show the cursor"

	self hasCursor
		ifTrue: [ ^ self ].

	self cursorExists
		ifFalse: [ cursorElement := self defaultCursor ].

	self addChild: self cursorElement
]

{ #category : #'cursor - management' }
BlTextEditElement >> showCursorAt: anIndex [
	"Show a cursor at a given text index"

	self showCursor.
	cursorPosition := anIndex.
	self requestLayout.
	self assertCursor
]
