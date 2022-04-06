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
	#classVars : [
		'HorizontalScrolling'
	],
	#category : #'BlocHost-Morphic-Support'
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
BlMorphicEventHandler >> convertKeyFromEvent: aMorphicEvent [

	<return: #BlKeyboardKey>
	| aKeyValue aKey |
	self flag: 'use of the morphicEvent key instead of #keyValue'.
	aKeyValue := aMorphicEvent key value.
	self flag: 'Host stuffs should be used instead (indirectly BlOSWindowSDL2KeyboardKeyTable)'.
	aKey := BlMorphicKeyboardKeyTable default keyFromVirtualCode: aKeyValue.
	"on unix platorms, pressed shift changes the keycode"
	OSPlatform current isUnix ifTrue: [ 
		(aKey isShift not and: [ aMorphicEvent shiftPressed ]) ifTrue: [ 
			{ (BlKeyboardKey tab -> BlKeyboardKey return) } asDictionary
				at: aKey
				ifAbsent: [ aKey ] ] ].

	^ aKey
]

{ #category : #converting }
BlMorphicEventHandler >> convertKeyModifiersFromEvent: aMorphicEvent [ 
	| shift ctrl alt cmd |

	shift := aMorphicEvent shiftPressed.
	ctrl := aMorphicEvent controlKeyPressed.
	alt := aMorphicEvent altKeyPressed.
	cmd := aMorphicEvent commandKeyPressed.
	
	"on windows, alt is registered as CMD while CMD itself does not exist.
	https://github.com/feenkcom/gtoolkit/issues/557"
	OSPlatform current isWindows
		ifTrue: [
			alt := cmd.
			cmd := false ].
	
	^ BlKeyModifiers shift: shift ctrl: ctrl alt: alt cmd: cmd
]

{ #category : #'event handling' }
BlMorphicEventHandler >> convertMousePosition: anEvent andDo: aBlock [

	"changes event position to be relative to the panelRect, not to the world"
	anEvent setPosition: (self window pointToSpace: anEvent position).
	aBlock value: anEvent
]

{ #category : #'private - actions' }
BlMorphicEventHandler >> dropFiles: anEvent [
	"Handle a number of dropped files from the OS.
	TODO:
		- use a more general mechanism for figuring out what to do with the file (perhaps even offering a choice from a menu)
		- remember the resource location or (when in browser) even the actual file handle"
	| numFiles |	
	numFiles := anEvent contents.
	
	1 to: numFiles do: [:i | | aFileReference handler |
		aFileReference := FileReference requestDropReference: i.
		handler := ExternalDropHandler lookupExternalDropHandler: aFileReference.
		handler ifNotNil: [ aFileReference binaryWriteStreamDo: [ :stream | handler handle: stream in: self dropEvent: anEvent ] ]].
]

{ #category : #accessing }
BlMorphicEventHandler >> enqueue: aBlEvent [

	self isClosed
		ifTrue: [ ^ self ].

	self window hostSpace enqueueEvent: aBlEvent.
	self flag: 'ugly code to force the space to dequeue the event '.
	self window hostSpace space ifNotNil: [ :aSpace | aSpace requestNextPulse ]
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
		timestamp: self time now.

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
		timestamp: self time now.

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
		timestamp: self time now.

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
		timestamp: self time now.
	
	self unregisterPressedKey: BlKeyboardKey delete.
	self enqueue: aBlEvent
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleDropFiles: anEvent [
	"Handle a drop from the OS."
	anEvent wasHandled ifTrue: [ ^ self ]. "not interested"
	WorldMorph allowDropFiles ifFalse: [ ^ self ].
	anEvent wasHandled: true.
	self dropFiles: anEvent.
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
	"Ugly mouse hack: F12 (106) toggles a global variable to tell the mouse handler
	to scroll horizontally."
	aKey value = 106 ifTrue:
		[ self toggleHorizontalScrolling.
		^self ].

	self flag: 'No need to consider a special case for delete and backspace'.
	"we ignore `delete` keydown event because it is not distinguishable from backspace.
	we create keydown event in keystroke:"
	"(aKey = BlKeyboardKey delete or: [ aKey = BlKeyboardKey backspace ])
		ifTrue: [^ self handleDeleteOrBackspaceDown: aMorphicEvent]."
	
	"we ignore already pressed keys"
	(self hasPressedKey: aKey)
		ifTrue: [ ^ self ].
	
	theModifiers := self convertKeyModifiersFromEvent: aMorphicEvent.
	
	aBlEvent := BlKeyDownEvent new
		key: aKey;
		scanCode: aMorphicEvent scanCode;
		modifiers: theModifiers;
		timestamp: self time now.
	
	self registerPressedKey: aKey.

	self enqueue: aBlEvent
]

{ #category : #'events - keyboard' }
BlMorphicEventHandler >> handleKeyUp: aMorphicEvent [
	| aBlEvent aKey theModifiers |

	(self isScrollEvent: aMorphicEvent)
		ifTrue: [ ^ self ].

	aKey := self convertKeyFromEvent: aMorphicEvent.
	
	self flag: 'No need to consider a special case for delete and backspace'.
	"we can not differentiate between delete and backspace. However, we previously
	logged which exact key was pressed, so now we can nicely send a corresponding keyup event"
	"(aKey = BlKeyboardKey delete or: [ aKey = BlKeyboardKey backspace ])
		ifTrue: [ ^ self handleDeleteOrBackspaceUp: aMorphicEvent ]."
	
	theModifiers := self convertKeyModifiersFromEvent: aMorphicEvent.

	(self hasPressedKey: aKey)
		ifFalse: [ ^ self ].
	
	aBlEvent := BlKeyUpEvent new
		key: aKey;
		scanCode: aMorphicEvent scanCode;
		modifiers: theModifiers;
		timestamp: self time now.

	self unregisterPressedKey: aKey.
	self enqueue: aBlEvent
]

{ #category : #'events - keyboard' }
BlMorphicEventHandler >> handleKeystroke: aMorphicEvent [

	| aBlEvent |
	(aMorphicEvent shiftPressed and: [ aMorphicEvent controlKeyPressed ]) 
		ifTrue: [ 
			aMorphicEvent keyCharacter = Character arrowLeft ifTrue: [ 
				^ self handleScrollLeft: aMorphicEvent ].
			aMorphicEvent keyCharacter = Character arrowRight ifTrue: [ 
				^ self handleScrollRight: aMorphicEvent ] ].

	self flag: 'keystrokeEvent is not created for delete and backspace; no need to handle them '.
	"(aMorphicEvent keyCharacter = Character delete
		or: [ aMorphicEvent keyCharacter = Character backspace ])
			ifTrue: [ ^ self handleDeleteOrBackspaceDown: aMorphicEvent ]."

	aBlEvent := BlTextInputEvent new
		            text: aMorphicEvent keyCharacter asString;
		            modifiers:
			            (self convertKeyModifiersFromEvent: aMorphicEvent);
		            timestamp: DateAndTime now.

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
			timestamp: self time now;
			yourself.

		self enqueue: aBlEvent ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseOver: anEvent [
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseUp: anEvent [
	
	morph
		ifNil: [ ^ self ].
	
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
	
	morph ifNotNil: #takeKeyboardFocus
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseWheel: anEvent [
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent vectorOffset vector |

		vectorOffset := aMorphicEvent direction = Character arrowDown
			ifTrue: [ -5 ] 
			ifFalse: [ 5 ].
		vector := self horizontalScrolling 
			ifTrue: [ BlVector x: vectorOffset y: 0 ]
			ifFalse: [ BlVector x: 0 y: vectorOffset ].
		aBlEvent := BlMouseWheelEvent new
			vector: vector;
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			timestamp: DateAndTime now.
		
		self enqueue: aBlEvent ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleScrollLeft: anEvent [
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent |
		aBlEvent := BlMouseWheelEvent new
			vector: (BlVector x: -5 y: 0);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			button: (BlMouseButton code: aMorphicEvent buttons);
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			timestamp: DateAndTime now.
		self enqueue: aBlEvent ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleScrollRight: anEvent [
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent |

		aBlEvent := BlMouseWheelEvent new
			vector: (BlVector x: 5 y: 0);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			button: (BlMouseButton code: aMorphicEvent buttons);
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			timestamp: DateAndTime now.
		
		self enqueue: aBlEvent ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleWindowClosed: aMorphicEvent [
	| aBlEvent |

	aBlEvent := BlSpaceCloseRequest new timestamp: DateAndTime now.
	self enqueue: aBlEvent.

	morph := nil
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
	self enqueue: aBlEvent.
	
	self window hostSpace space pulse
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> hasPressedKey: aKey [
	^ pressedKeys includes: aKey
]

{ #category : #accessing }
BlMorphicEventHandler >> horizontalScrolling [ 

	^HorizontalScrolling ifNil: [ HorizontalScrolling := false ]
]

{ #category : #initialization }
BlMorphicEventHandler >> initialize [
	super initialize.

	pressedKeys := Set new.
	HorizontalScrolling := false.
]

{ #category : #'private - testing' }
BlMorphicEventHandler >> isClosed [
	^ morph isNil
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

{ #category : #accessing }
BlMorphicEventHandler >> time [
	<return: #BlTime>

	^ self window hostSpace space time
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> toggleHorizontalScrolling [

	HorizontalScrolling := self horizontalScrolling not.
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
