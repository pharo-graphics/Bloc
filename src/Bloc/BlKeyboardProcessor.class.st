"
I am responsible of handling keyboard events (typically sent by a host space to a space), and dispatching more high-level events such a `BlShortcutEvent`s.
"
Class {
	#name : #BlKeyboardProcessor,
	#superclass : #BlBaseEventProcessor,
	#instVars : [
		'buffer',
		'textInputBuffer',
		'preventKeystrokes',
		'shortcutRepeatDelay',
		'shortcutRepeatInterval',
		'previousShortcutTime',
		'previousShortcutRepeatTime'
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

	^ (self space focusProcessor hasFocusOwner and: [
		self space focusProcessor focusOwner isAttachedToSceneGraph ])
			ifTrue: [ self space focusProcessor focusOwner ]
			ifFalse: [ self space root ]
]

{ #category : #'event processing' }
BlKeyboardProcessor >> handleSpaceEventProcessedEvent: anEvent [

	| aShortcutEvent aTimeNow |
	self processBufferedTextInput.

	buffer isEmpty ifTrue: [ ^ self ].

	aTimeNow := self space time now.

	aTimeNow - previousShortcutTime < shortcutRepeatDelay
		ifTrue: [ ^ self ].

	aTimeNow - previousShortcutRepeatTime < shortcutRepeatInterval
		ifTrue: [ ^ self ].

	aShortcutEvent := BlShortcutEvent new.
	aShortcutEvent beRepeated.
	aShortcutEvent buffer: buffer.
	aShortcutEvent target: self detectTarget.
	self fireEvent: aShortcutEvent.

	previousShortcutRepeatTime := self space time now
]

{ #category : #initialization }
BlKeyboardProcessor >> initialize [

	super initialize.

	buffer := BlKeyboardBuffer new.
	textInputBuffer := BlTextInputBuffer new.
	preventKeystrokes := false.

	"how often a shortcut even should be sent while user still presses keys"
	shortcutRepeatInterval := 100 milliSeconds.
	"how much we should wait until starting to repeat a shortcut"
	shortcutRepeatDelay := 500 milliSeconds.

	"when the previous main shortcut event was sent"
	previousShortcutTime := space time now. 
	"when the last repeated shortcut was sent"
	previousShortcutRepeatTime := space time now
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processBufferedTextInput [

	| aTarget |
	aTarget := nil.

	textInputBuffer textInputEventsDo: [ :eachEvent |
		"initialize target here to not search for the target if there are no buffered input"
		aTarget ifNil: [ aTarget := self detectTarget ].
		eachEvent target: aTarget.
		self fireEvent: eachEvent ].

	textInputBuffer reset
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processKeyDown: anEvent [

	| aTarget aShortcutEvent |
	(buffer hasEvent: anEvent key) ifTrue: [ ^ self ].

	buffer add: anEvent.

	aTarget := self detectTarget.
	anEvent target: aTarget.
	self fireEvent: anEvent.

	aShortcutEvent := BlShortcutEvent new.
	aShortcutEvent buffer: buffer.
	aShortcutEvent target: aTarget.
	aShortcutEvent modifiers: anEvent modifiers.

	self fireEvent: aShortcutEvent.

	previousShortcutTime := self space time now.

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
