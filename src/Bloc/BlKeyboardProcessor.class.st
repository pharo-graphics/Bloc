"
# Keyboard event processor
Is responsible for processing {{gtClass:BlKeyboardEvent}} which are sent by the {{gtClass:TBlHostSpace}} to the {{gtClass:BlSpace}}. In addition, the `keyboard event processor` generates additional events such as {{gtClass:BlShortcutEvent}} 

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

{ #category : #accessing }
BlKeyboardProcessor >> buffer [
	<return: #BlKeyboardBuffer>

	^ buffer
]

{ #category : #'target detection' }
BlKeyboardProcessor >> findTarget [
	"Find and return an appropriate element target for a keyboard event.
	By default a keyboard event target is currently focused element if exists
	or space's root element otherwise.
	Note: target can not be nil"
	<return: #BlElement>

	^ (self space focusProcessor hasFocusOwner and: [ self space focusProcessor focusOwner isAttachedToSceneGraph ])
		ifTrue: [ self space focusProcessor focusOwner ]
		ifFalse: [ self space root ]
]

{ #category : #'event processing' }
BlKeyboardProcessor >> handleSpaceEventProcessedEvent: anEvent [
	| aShortcutEvent aTimeNow |
	
	self processBufferedTextInput.

	self buffer isEmpty
		ifTrue: [ ^ self ].
	
	aTimeNow := self space time now.
	
	(aTimeNow - previousShortcutTime) < shortcutRepeatDelay
		ifTrue: [ ^ self ].

	(aTimeNow - previousShortcutRepeatTime) < shortcutRepeatInterval
		ifTrue: [ ^ self ].
	
	aShortcutEvent := BlShortcutEvent new.
	aShortcutEvent beRepeated.
	aShortcutEvent buffer: self buffer.
	aShortcutEvent target: self findTarget.
	self fireEvent: aShortcutEvent.

	previousShortcutRepeatTime := self space time now
]

{ #category : #initialization }
BlKeyboardProcessor >> initialize [
	super initialize.
	
	buffer := BlKeyboardBuffer new.
	textInputBuffer := BlTextInputBuffer new.
	preventKeystrokes := false.

	shortcutRepeatInterval := 100 milliSeconds. "how often a shortcut even should be sent while user still presses keys"
	shortcutRepeatDelay := 500 milliSeconds. "how much we should wait until starting to repeat a shortcut"

	previousShortcutTime := DateAndTime now. "when the previous main shortcut event was sent"
	previousShortcutRepeatTime := DateAndTime now. "when the last repeated shortcut was sent"
]

{ #category : #testing }
BlKeyboardProcessor >> keystrokesAllowed [
	"Return true if keystrokes are allowed, false otherwise"
	<return: #Boolean>

	^ preventKeystrokes not
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processBufferedTextInput [
	| aTarget |

	aTarget := nil.

	textInputBuffer textInputEventsDo: [ :eachEvent |
		"initialize target here to not search for the target if there are no buffered input"
		aTarget
			ifNil: [ aTarget := self findTarget ].
		eachEvent
			timestamp: self space time now;
			target: aTarget.
		self fireEvent: eachEvent ].
	
	textInputBuffer reset
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processKeyDown: anEvent [
	| aTarget aShortcutEvent |

	(self buffer hasEvent: anEvent key)
		ifTrue: [ ^ self ].

	self buffer add: anEvent.
	
	aTarget := self telemetry
		timeSync: [ 'Find key down target ' ]
		during: [ self findTarget ].

	anEvent target: aTarget.
	
	self telemetry
		timeSync: [ 'Fire key down event ' ]
		during: [ self fireEvent: anEvent ].

	aShortcutEvent := BlShortcutEvent new.
	aShortcutEvent buffer: self buffer.
	aShortcutEvent target: aTarget.
	aShortcutEvent modifiers: anEvent modifiers.

	self telemetry
		timeSync: [ 'Fire shortcut event ' ]
		during: [ self fireEvent: aShortcutEvent ].

	previousShortcutTime := self space time now.

	preventKeystrokes := aShortcutEvent isConsumed
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processKeyUp: anEvent [
	| aTarget |

	(self buffer hasEvent: anEvent key)
		ifFalse: [ ^ self ].
	
	self buffer remove: anEvent.
	
	aTarget := self telemetry
		timeSync: [ 'Find key up target ' ]
		during: [ self findTarget ].

	anEvent target: aTarget.

	self telemetry
		timeSync: [ 'Fire key up event ' ]
		during: [ self fireEvent: anEvent ].

	self buffer isEmpty
		ifTrue: [ preventKeystrokes := false ]
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processTextInput: anEvent [	
	self keystrokesAllowed
		ifFalse: [ ^ self ].
	
	textInputBuffer
		text: anEvent text
		modifiers: anEvent modifiers
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processWindowFocusOut: anEvent [

	"Take all registered key down events from the buffer and send them as key up events to release keys"
	self buffer events
		collect: [ :aKeyDownEvent |
			BlKeyUpEvent new
				key: aKeyDownEvent key;
				scanCode: aKeyDownEvent scanCode;
				timestamp: self space time now ]
		thenDo: [ :aKeyUpEvent | self processKeyUp: aKeyUpEvent ]
]
