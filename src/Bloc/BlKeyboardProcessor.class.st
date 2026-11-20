"
I am responsible of handling keyboard events (typically sent by a host space to a space), and dispatching more high-level events such a `BlShortcutEvent`s.
"
Class {
	#name : #BlKeyboardProcessor,
	#superclass : #BlBaseEventProcessor,
	#instVars : [
		'buffer',
		'textInputBuffer',
		'preventKeystrokes'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #testing }
BlKeyboardProcessor >> areKeystrokesAllowed [
	"Return true if keystrokes are allowed, false otherwise"

	^ preventKeystrokes not
]

{ #category : #accessing }
BlKeyboardProcessor >> buffer [

	^ buffer
]

{ #category : #'target detection' }
BlKeyboardProcessor >> detectTarget [
	"Answer an appropriate element target for a keyboard event.
	By default a keyboard event target is currently focused element if exists
	or space's root element otherwise.
	Note: target can not be nil"

	^ (self space focusOwner isNotNil and: [
		self space focusOwner isAttachedToSceneGraph ])
			ifTrue: [ self space focusOwner ]
			ifFalse: [ self space root ]
]

{ #category : #'event processing' }
BlKeyboardProcessor >> handleSpaceEventProcessedEvent: anEvent [

	| aTarget |
	aTarget := nil.

	textInputBuffer textInputEventsDo: [ :eachEvent |
		"initialize target here to not search for the target if there are no buffered input"
		aTarget ifNil: [ aTarget := self detectTarget ].
		eachEvent target: aTarget.
		self fireEvent: eachEvent ].

	textInputBuffer reset
]

{ #category : #initialization }
BlKeyboardProcessor >> initialize [

	super initialize.

	buffer := BlKeyboardBuffer new.
	textInputBuffer := BlTextInputBuffer new.
	preventKeystrokes := false
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processKeyDown: anEvent [

	| aTarget aShortcutEvent |
	(anEvent isRepeated not and: [ buffer hasEvent: anEvent key ]) ifTrue: [ ^ self ].

	buffer add: anEvent.

	aTarget := self detectTarget.
	anEvent target: aTarget.
	self fireEvent: anEvent.

	aShortcutEvent :=
		BlShortcutEvent new
			buffer: buffer;
			target: aTarget;
			modifiers: anEvent modifiers;
			isRepeated: anEvent isRepeated;
			yourself.

	self fireEvent: aShortcutEvent.

	preventKeystrokes := aShortcutEvent isConsumed
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processKeyUp: anEvent [

	| aTarget |
	(buffer hasEvent: anEvent key) ifFalse: [ ^ self ].

	buffer remove: anEvent.

	aTarget := self detectTarget.
	anEvent target: aTarget.
	self fireEvent: anEvent.

	buffer isEmpty ifTrue: [ preventKeystrokes := false ]
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processTextInput: anEvent [

	self areKeystrokesAllowed ifFalse: [ ^ self ].

	textInputBuffer text: anEvent text modifiers: anEvent modifiers
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processWindowFocusOut: anEvent [
	"When a host space looses focus, we won't receive the key ups for the buffered keys. So, take all registered key down events from the buffer and send them as key up events to release keys"

	buffer events
		collect: [ :aKeyDownEvent |
			BlKeyUpEvent new
				key: aKeyDownEvent key;
				scanCode: aKeyDownEvent scanCode;
				yourself ]
		thenDo: [ :aKeyUpEvent | self processKeyUp: aKeyUpEvent ]
]
