Class {
	#name : #BlKeyboardProcessor,
	#superclass : #BlBaseEventProcessor,
	#instVars : [
		'buffer',
		'preventKeystrokes'
	],
	#category : 'Bloc-Space-Support'
}

{ #category : #accessing }
BlKeyboardProcessor >> buffer [
	^ buffer
]

{ #category : #'target detection' }
BlKeyboardProcessor >> findTarget: anEvent [
	"Find and return an appropriate element target for a given keyboard event.
	By default a keyboard event target is currently focused element if exists
	or space's root element otherwise.
	Note: target can not be nil"
	<return: #BlElement>

	^ self space focusProcessor hasFocusOwner
		ifTrue: [ self space focusProcessor focusOwner ]
		ifFalse: [ self space root ]
]

{ #category : #'event processing' }
BlKeyboardProcessor >> handleSpaceEventProcessedEvent: anEvent [
	
]

{ #category : #initialization }
BlKeyboardProcessor >> initialize [
	super initialize.
	
	buffer := BlKeyboardBuffer new.
	preventKeystrokes := false
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
BlKeyboardProcessor >> processKeystroke: anEvent [
	| aTarget |
	
	self keystrokesAllowed
		ifFalse: [ ^ self ].

	aTarget := self findTarget: anEvent.
	anEvent target: aTarget.
	self fireEvent: anEvent.
]

{ #category : #'event processing' }
BlKeyboardProcessor >> processTextInput: anEvent [
	| aTarget |
	
	aTarget := self findTarget: anEvent.
	anEvent target: aTarget.
	self fireEvent: anEvent.
]
