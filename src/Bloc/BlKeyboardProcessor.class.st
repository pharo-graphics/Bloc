Class {
	#name : #BlKeyboardProcessor,
	#superclass : #BlBaseEventProcessor,
	#instVars : [
		'buffer',
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
BlKeyboardProcessor >> findTarget: anEvent [
	"Find and return an appropriate element target for a given keyboard event.
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
	aShortcutEvent target: (self findTarget: anEvent).
	self fireEvent: aShortcutEvent.

	previousShortcutRepeatTime := self space time now
]

{ #category : #initialization }
BlKeyboardProcessor >> initialize [
	super initialize.
	
	buffer := BlKeyboardBuffer new.
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
BlKeyboardProcessor >> processKeyDown: anEvent [
	| aTarget aShortcutEvent |

	(self buffer hasEvent: anEvent key)
		ifTrue: [ ^ self ].

	self buffer add: anEvent.
	
	aTarget := self findTarget: anEvent.
	anEvent target: aTarget.
	self fireEvent: anEvent.

	aShortcutEvent := BlShortcutEvent new.
	aShortcutEvent buffer: self buffer.
	aShortcutEvent target: aTarget.
	self fireEvent: aShortcutEvent.
	previousShortcutTime := self space time now.

	preventKeystrokes := aShortcutEvent isConsumed
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processKeyUp: anEvent [
	| aTarget |

	(self buffer hasEvent: anEvent key)
		ifFalse: [ ^ self ].
	
	self buffer remove: anEvent.
	
	aTarget := self findTarget: anEvent.
	anEvent target: aTarget.
	self fireEvent: anEvent
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processTextInput: anEvent [
	| aTarget |
	
	self keystrokesAllowed
		ifFalse: [ ^ self ].

	aTarget := self findTarget: anEvent.
	anEvent target: aTarget.
	self fireEvent: anEvent
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processWindowFocusOut: anEvent [

	"Take all registered key down events from the buffer and send them as key up events to release keys"
	self buffer events
		collect: [ :aKeyDownEvent |
			BlKeyUpEvent new
				key: aKeyDownEvent key;
				scanCode: aKeyDownEvent scanCode;
				timestamp: self space time now;
				position: aKeyDownEvent position;
				screenPosition: aKeyDownEvent screenPosition ]
		thenDo: [ :aKeyUpEvent | self processKeyUp: aKeyUpEvent ]
]
