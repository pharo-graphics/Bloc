"
I am a morphic event handler.
I am responsible for convertion of moprhic events to bloc events and their enqueuing.

I know morphic window I belong to
"
Class {
	#name : #BlMorphicEventHandler,
	#superclass : #Object,
	#instVars : [
		'morph',
		'pressedKeys'
	],
	#category : #'BlocHost-Morphic-Host'
}

{ #category : #'instance creation' }
BlMorphicEventHandler class >> window: aMorphicWindow [
	^ self new
		window: aMorphicWindow;
		yourself
]

{ #category : #converting }
BlMorphicEventHandler >> convertButtonFromMouseButtonEvent: aMorphicEvent [
	<return: #BlMouseButton>

	aMorphicEvent redButtonChanged
		ifTrue: [ ^ BlMouseButton primary ].
	aMorphicEvent blueButtonChanged
		ifTrue: [ ^ BlMouseButton middle ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ ^ BlMouseButton secondary ].
	^ BlMouseButton code: aMorphicEvent whichButton
]

{ #category : #converting }
BlMorphicEventHandler >> convertButtonFromMouseEvent: aMorphicEvent [

	aMorphicEvent redButtonPressed
		ifTrue: [ ^ BlMouseEvent primaryButton ].
	aMorphicEvent blueButtonPressed
		ifTrue: [ ^ BlMouseEvent middleButton ].
	aMorphicEvent yellowButtonPressed
		ifTrue: [ ^ BlMouseEvent secondaryButton ].
		
	^ aMorphicEvent buttons
]

{ #category : #converting }
BlMorphicEventHandler >> convertKeyFromEvent: aMorphicEvent [
	<return: #BlKeyboardKey>

	^ BlMorphicKeyboardKeyTable default keyFromScanCode: aMorphicEvent scanCode
]

{ #category : #converting }
BlMorphicEventHandler >> convertKeyModifiersFromEvent: aMorphicEvent [ 
	| shift ctrl alt cmd |

	shift := aMorphicEvent shiftPressed.
	ctrl := aMorphicEvent controlKeyPressed.
	alt := aMorphicEvent altKeyPressed.
	cmd := aMorphicEvent commandKeyPressed.
	
	^ BlKeyModifiers shift: shift ctrl: ctrl alt: alt cmd: cmd
]

{ #category : #'event handling' }
BlMorphicEventHandler >> convertMousePosition: anEvent andDo: aBlock [

	"changes event position to be relative to the panelRect, not to the world"
	anEvent setPosition: (self window pointToSpace: anEvent position).
	aBlock value: anEvent
]

{ #category : #accessing }
BlMorphicEventHandler >> enqueue: aBlEvent [
	self window hostSpace enqueueEvent: aBlEvent
]

{ #category : #converting }
BlMorphicEventHandler >> globalMousePositionForEvent: anEvent [
	^ morph position + anEvent position
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleBackspaceDown: aMorphicEvent [
	| aBlEvent |
	
	aBlEvent := BlKeyDownEvent new
		key: BlKeyboardKey backspace;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: DateAndTime now;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).

	self registerPressedKey: BlKeyboardKey backspace.
	self enqueue: aBlEvent
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleBackspaceUp: aMorphicEvent [
	| aBlEvent |

	aBlEvent := BlKeyUpEvent new
		key: BlKeyboardKey backspace;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: DateAndTime now;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).

	self unregisterPressedKey: BlKeyboardKey backspace.
	self enqueue: aBlEvent
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleDeleteDown: aMorphicEvent [
	| aBlEvent |

	aBlEvent := BlKeyDownEvent new
		key: BlKeyboardKey delete;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: DateAndTime now;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).

	self registerPressedKey: BlKeyboardKey delete.

	self enqueue: aBlEvent
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleDeleteOrBackspaceDown: aMorphicEvent [

	"we only allow either delete or backspace key"
	(self hasPressedKey: BlKeyboardKey backspace)
		ifTrue: [ ^ self ].
		
	(self hasPressedKey: BlKeyboardKey delete)
		ifTrue: [ ^ self ].
	
	aMorphicEvent keyCharacter = Character delete
		ifTrue: [ ^ self handleDeleteDown: aMorphicEvent ].
		
	aMorphicEvent keyCharacter = Character backspace
		ifTrue: [ ^ self handleBackspaceDown: aMorphicEvent ]
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleDeleteOrBackspaceUp: aMorphicEvent [

	(self hasPressedKey: BlKeyboardKey delete)
		ifTrue: [ ^ self handleDeleteUp: aMorphicEvent ].

	(self hasPressedKey: BlKeyboardKey backspace)
		ifTrue: [ ^ self handleBackspaceUp: aMorphicEvent ]
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleDeleteUp: aMorphicEvent [
	| aBlEvent |

	aBlEvent := BlKeyUpEvent new
		key: BlKeyboardKey delete;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: DateAndTime now;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).
	
	self unregisterPressedKey: BlKeyboardKey delete.
	self enqueue: aBlEvent
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleDropMorph: anEvent [
	"| pos |
	pos := anEvent position - self window position.
	anEvent setPosition: pos contents: anEvent contents hand: anEvent hand.
	self enqueue: anEvent"
]

{ #category : #'events - keyboard' }
BlMorphicEventHandler >> handleKeyDown: aMorphicEvent [
	| aBlEvent aKey theModifiers |
	
	(self isScrollEvent: aMorphicEvent)
		ifTrue: [ ^ self ].

	aKey := self convertKeyFromEvent: aMorphicEvent.
	
	"we ignore `delete` keydown event because it is not distinguishable from backspace.
	we create keydown event in keystroke:"
	(aKey = BlKeyboardKey delete or: [ aKey = BlKeyboardKey backspace ])
		ifTrue: [ ^ self ].
	
	"we ignore already pressed keys"
	(self hasPressedKey: aKey)
		ifTrue: [ ^ self ].
	
	theModifiers := self convertKeyModifiersFromEvent: aMorphicEvent.
	
	aBlEvent := BlKeyDownEvent new
		key: aKey;
		scanCode: aMorphicEvent scanCode;
		modifiers: theModifiers;
		timestamp: DateAndTime now;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).
	
	self registerPressedKey: aKey.

	self enqueue: aBlEvent
]

{ #category : #'events - keyboard' }
BlMorphicEventHandler >> handleKeyUp: aMorphicEvent [
	| aBlEvent aKey |
	
	(self isScrollEvent: aMorphicEvent)
		ifTrue: [ ^ self ].
		
	aKey := self convertKeyFromEvent: aMorphicEvent.
	
	"we can not differentiate between delete and backspace. However, we previously
	logged which exact key was pressed, so now we can nicely send a corresponding keyup event"
	(aKey = BlKeyboardKey delete or: [ aKey = BlKeyboardKey backspace ])
		ifTrue: [ ^ self handleDeleteOrBackspaceUp: aMorphicEvent ].
	
	(self hasPressedKey: aKey)
		ifFalse: [ ^ self ].
	
	aBlEvent := BlKeyUpEvent new
		key: aKey;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: DateAndTime now;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).

	self unregisterPressedKey: aKey.
	self enqueue: aBlEvent
]

{ #category : #'events - keyboard' }
BlMorphicEventHandler >> handleKeystroke: aMorphicEvent [
	| aBlEvent |

	(aMorphicEvent shiftPressed and: [ aMorphicEvent controlKeyPressed ])
		ifTrue: [
			aMorphicEvent keyCharacter = Character arrowLeft
				ifTrue: [ ^ self handleScrollLeft: aMorphicEvent ].
			aMorphicEvent keyCharacter = Character arrowRight
				ifTrue: [ ^ self handleScrollRight: aMorphicEvent ] ].
			
	(aMorphicEvent keyCharacter = Character delete
		or: [ aMorphicEvent keyCharacter = Character backspace ])
			ifTrue: [ ^ self handleDeleteOrBackspaceDown: aMorphicEvent ].
	
	aBlEvent := BlKeystrokeEvent new
		char: aMorphicEvent keyCharacter;
		scanCode: aMorphicEvent scanCode;
		
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: DateAndTime now;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).
	
	self enqueue: aBlEvent
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseDown: anEvent [

	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent |
		aBlEvent := BlMouseDownEvent new
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			button: (self convertButtonFromMouseButtonEvent: aMorphicEvent);
			timestamp: DateAndTime now;
			yourself.
		self enqueue: aBlEvent ].
	
	morph takeKeyboardFocus
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseEnter: anEvent [
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseLeave: anEvent [
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseMove: anEvent [
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent |

		aBlEvent := BlMouseMoveEvent new
			position: aMorphicEvent position;
			delta: aMorphicEvent position - (self window pointToSpace: aMorphicEvent startPoint);
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			timestamp: DateAndTime now;
			yourself.
		self enqueue: aBlEvent ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseOver: anEvent [
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseUp: anEvent [

	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent |
		aBlEvent := BlMouseUpEvent new
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			button: (self convertButtonFromMouseButtonEvent: aMorphicEvent);
			timestamp: DateAndTime now;
			yourself.
		self enqueue: aBlEvent ].
	
	morph takeKeyboardFocus.
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseWheel: anEvent [
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent |

		aBlEvent := BlMouseWheelEvent new
			vector: (BlVector x: 0 y: (aMorphicEvent direction = Character arrowDown
				ifTrue: [ -2 ] ifFalse: [ 2 ]));
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			direction: aMorphicEvent direction;
			timestamp: DateAndTime now.
		
		self enqueue: aBlEvent ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleScrollLeft: anEvent [
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent |
		aBlEvent := BlMouseWheelEvent new
			vector: (BlVector x: -2 y: 0);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			button: (BlMouseButton code: aMorphicEvent buttons);
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			direction: aMorphicEvent keyCharacter;
			timestamp: DateAndTime now.
		
		self enqueue: aBlEvent ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleScrollRight: anEvent [
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent |

		aBlEvent := BlMouseWheelEvent new
			vector: (BlVector x: 2 y: 0);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			button: (BlMouseButton code: aMorphicEvent buttons);
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			direction: aMorphicEvent keyCharacter;
			timestamp: DateAndTime now.
		
		self enqueue: aBlEvent ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleWindowClosed: aMorphicEvent [
	| aBlEvent |

	aBlEvent := BlSpaceCloseRequest new
		timestamp: DateAndTime now.
	
	self enqueue: aBlEvent
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleWindowEvent: anEvent [
	
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleWindowOpened: aMorphicEvent [
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleWindowResize: aMorphicEvent [
	| aBlEvent |
	aBlEvent := BlSpaceResizedEvent new
		extent: aMorphicEvent width @ aMorphicEvent height;
		timestamp: DateAndTime now;
		yourself.
	self enqueue: aBlEvent
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> hasPressedKey: aKey [
	^ pressedKeys includes: aKey
]

{ #category : #initialization }
BlMorphicEventHandler >> initialize [
	super initialize.

	pressedKeys := Set new
]

{ #category : #'private - testing' }
BlMorphicEventHandler >> isScrollEvent: aMorphicKeyEvent [
	"Return true if a given morphic key event is in fact a scroll event.
	It is a morphic issue, that mouse wheel or touchpad events are
	in fact keyboard events..."

	^ (aMorphicKeyEvent shiftPressed
			and: [ aMorphicKeyEvent controlKeyPressed
				and: [ aMorphicKeyEvent optionKeyPressed
					and: [ aMorphicKeyEvent keyCharacter = Character arrowDown
						or: [ aMorphicKeyEvent keyCharacter = Character arrowUp
							or: [ aMorphicKeyEvent keyCharacter = Character arrowLeft
								or: [ aMorphicKeyEvent keyCharacter = Character arrowRight
									or: [ aMorphicKeyEvent keyCharacter = Character null ] ] ] ] ] ] ])
]

{ #category : #accessing }
BlMorphicEventHandler >> morph [
	^ morph
]

{ #category : #accessing }
BlMorphicEventHandler >> morph: aMorph [
	morph := aMorph
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> registerPressedKey: aKey [
	pressedKeys add: aKey
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> unregisterPressedKey: aKey [
	pressedKeys remove: aKey
]

{ #category : #accessing }
BlMorphicEventHandler >> window [
	^ self morph
]

{ #category : #accessing }
BlMorphicEventHandler >> window: aBlMorphicWindow [
	self morph: aBlMorphicWindow
]
