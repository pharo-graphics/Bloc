"
I am a morphic event handler.
I am responsible for convertion of moprhic events to bloc events and their enqueuing.

I know morphic window I belong to
"
Class {
	#name : #BlMorphicEventHandler,
	#superclass : #Object,
	#instVars : [
		'pressedKeys',
		'windowMorph'
	],
	#classVars : [
		'HorizontalScrolling'
	],
	#category : #'BlocHost-Morphic-Common'
}

{ #category : #'instance creation' }
BlMorphicEventHandler class >> window: aMorphicWindow [

	^ self new
		window: aMorphicWindow;
		yourself
]

{ #category : #converting }
BlMorphicEventHandler >> convertButtonFromMouseButtonEvent: aMorphicEvent [

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
	"Answer a platform-idependent `KeyboardKey` from the event. On Unix platorms, pressed shift changes the keycode."

	| aKey |
	aKey := aMorphicEvent key.

	OSPlatform current isUnix ifTrue: [ 
		(aKey isShift not and: [ aMorphicEvent shiftPressed ]) ifTrue: [ 
			{ (KeyboardKey tab -> KeyboardKey enter) } asDictionary
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
	Based on homonymous method in `PasteUpMorph`"

	| numFiles |
	numFiles := anEvent contents.
	1 to: numFiles do: [ :i |
		| aFileReference handler |
		aFileReference := anEvent requestDropReference: i.
		handler := ExternalDropHandler lookupExternalDropHandler: aFileReference.
		handler ifNotNil: [
			handler handle: aFileReference in: self dropEvent: anEvent ] ]
]

{ #category : #accessing }
BlMorphicEventHandler >> enqueue: aBlEvent [

	self isClosed ifTrue: [ ^ self ].

	aBlEvent fillFromTime: windowMorph hostSpace space time.

	windowMorph hostSpace enqueueEvent: aBlEvent.
	self flag: 'ugly code to force the space to dequeue the event '.
	windowMorph hostSpace space ifNotNil: [ :aSpace | aSpace requestNextPulse ]
]

{ #category : #converting }
BlMorphicEventHandler >> globalMousePositionForEvent: anEvent [

	^ windowMorph position + anEvent position
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleBackspaceDown: aMorphicEvent [

	| aBlEvent |
	aBlEvent := BlKeyDownEvent new
		key: KeyboardKey backspace;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		yourself.

	self registerPressedKey: KeyboardKey backspace.
	self enqueue: aBlEvent
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleBackspaceUp: aMorphicEvent [

	| aBlEvent |
	aBlEvent := BlKeyUpEvent new
		key: KeyboardKey backspace;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		yourself.

	self unregisterPressedKey: KeyboardKey backspace.
	self enqueue: aBlEvent
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleDeleteDown: aMorphicEvent [

	| aBlEvent |
	aBlEvent := BlKeyDownEvent new
		key: KeyboardKey delete;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		yourself.

	self registerPressedKey: KeyboardKey delete.
	self enqueue: aBlEvent
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleDeleteOrBackspaceDown: aMorphicEvent [
	"we only allow either delete or backspace key"

	(self hasPressedKey: KeyboardKey backspace) ifTrue: [ ^ self ].

	(self hasPressedKey: KeyboardKey delete) ifTrue: [ ^ self ].

	aMorphicEvent keyCharacter = Character delete ifTrue: [
		^ self handleDeleteDown: aMorphicEvent ].

	aMorphicEvent keyCharacter = Character backspace ifTrue: [
		^ self handleBackspaceDown: aMorphicEvent ]
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleDeleteOrBackspaceUp: aMorphicEvent [

	(self hasPressedKey: KeyboardKey delete)
		ifTrue: [ ^ self handleDeleteUp: aMorphicEvent ].

	(self hasPressedKey: KeyboardKey backspace)
		ifTrue: [ ^ self handleBackspaceUp: aMorphicEvent ]
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> handleDeleteUp: aMorphicEvent [

	| aBlEvent |
	aBlEvent := BlKeyUpEvent new
		key: KeyboardKey delete;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		yourself.
	
	self unregisterPressedKey: KeyboardKey delete.
	self enqueue: aBlEvent
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleDropFiles: anEvent [
	"Handle a drop from the OS."

	anEvent wasHandled ifTrue: [ ^ self ]. "not interested"
	WorldMorph allowDropFiles ifFalse: [ ^ self ].
	anEvent wasHandled: true.
	self dropFiles: anEvent
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleDropMorph: anEvent [
	"| pos |
	pos := anEvent position - self window position.
	anEvent setPosition: pos contents: anEvent contents hand: anEvent hand.
	self enqueue: anEvent"
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleExtentChanged: aMorphicEvent [

	self enqueue:
		(BlSpaceResizedEvent new
			extent: aMorphicEvent newExtent;
			yourself)
]

{ #category : #'events - keyboard' }
BlMorphicEventHandler >> handleKeyDown: aMorphicEvent [

	| aBlEvent aKey theModifiers |

	(self isScrollEvent: aMorphicEvent) ifTrue: [ ^ self ].

	aKey := self convertKeyFromEvent: aMorphicEvent.

	"Ugly mouse hack: F12 (106) toggles a global variable to tell the mouse handler
	to scroll horizontally."
	aKey value = 106 ifTrue: [
		self toggleHorizontalScrolling.
		^ self ].

	"we ignore already pressed keys"
	(self hasPressedKey: aKey) ifTrue: [ ^ self ].
	
	theModifiers := self convertKeyModifiersFromEvent: aMorphicEvent.
	
	aBlEvent := BlKeyDownEvent new
		key: aKey;
		scanCode: aMorphicEvent scanCode;
		modifiers: theModifiers;
		yourself.
	
	self registerPressedKey: aKey.

	self enqueue: aBlEvent
]

{ #category : #'events - keyboard' }
BlMorphicEventHandler >> handleKeyUp: aMorphicEvent [

	| aBlEvent aKey theModifiers |

	(self isScrollEvent: aMorphicEvent) ifTrue: [ ^ self ].

	aKey := self convertKeyFromEvent: aMorphicEvent.
	theModifiers := self convertKeyModifiersFromEvent: aMorphicEvent.

	(self hasPressedKey: aKey) ifFalse: [ ^ self ].
	
	aBlEvent := BlKeyUpEvent new
		key: aKey;
		scanCode: aMorphicEvent scanCode;
		modifiers: theModifiers;
		yourself.

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

	aBlEvent := BlTextInputEvent new
		            text: aMorphicEvent keyCharacter asString;
		            modifiers:
			            (self convertKeyModifiersFromEvent: aMorphicEvent);
		            yourself.

	self enqueue: aBlEvent
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMorphDeleted: aMorphDeleted [ 

	self enqueue: BlSpaceCloseRequest new.

	windowMorph := nil
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMorphGotFocus: aMorphGotFocus [ 

	self enqueue: BlSpaceFocusInEvent new
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMorphLostFocus: aMorphLostFocus [

	self enqueue: BlSpaceFocusOutEvent new
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMorphOpened: aMorphOpened [ 

]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseDown: anEvent [

	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent button |
		button := self convertButtonFromMouseButtonEvent: aMorphicEvent.

		aBlEvent := button mouseDownEventClass new
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			button: button;
			yourself.

		self enqueue: aBlEvent ].
	
	windowMorph takeKeyboardFocus
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
			yourself.

		self enqueue: aBlEvent ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseOver: anEvent [
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseUp: anEvent [
	
	windowMorph ifNil: [ ^ self ].
	
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent button |
		button := self convertButtonFromMouseButtonEvent: aMorphicEvent.

		aBlEvent := button mouseUpEventClass new
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			button: button;
			yourself.

		self enqueue: aBlEvent ].
	
	windowMorph ifNotNil: [ windowMorph takeKeyboardFocus ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleMouseWheel: anEvent [

	self convertMousePosition: anEvent andDo: [ :aMorphicEvent |
		| aBlEvent vectorOffset vector |
		vectorOffset := (aMorphicEvent direction = Character arrowDown or: [
			                 aMorphicEvent direction = Character arrowLeft ])
			                ifTrue: [ -5 ]
			                ifFalse: [ 5 ].
		vector := (aMorphicEvent direction = Character arrowLeft or: [
			           aMorphicEvent direction = Character arrowRight ])
			          ifTrue: [ BlVector x: vectorOffset y: 0 ]
			          ifFalse: [ BlVector x: 0 y: vectorOffset ]. " self horizontalScrolling "

		aBlEvent := BlMouseWheelEvent new
			            vector: vector;
			            modifiers:
				            (self convertKeyModifiersFromEvent: aMorphicEvent);
			            position: aMorphicEvent position;
			            screenPosition:
				            (self globalMousePositionForEvent: aMorphicEvent);
			            yourself.

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
			yourself.

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
			yourself.
		
		self enqueue: aBlEvent ]
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleTextEditionEvent: anEvent [

]

{ #category : #'events - keyboard' }
BlMorphicEventHandler >> handleTextInputEvent: aTextInputEvent [

	| aBlEvent |
	aBlEvent := BlTextInputEvent new
		            text: aTextInputEvent text asString;
		            modifiers: (BlKeyModifiers
				             shift: false
				             ctrl: false
				             alt: false
				             cmd: false);
		            yourself.

	self enqueue: aBlEvent
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleWindowClosed: aMorphicEvent [

	self enqueue: BlSpaceCloseRequest new.

	windowMorph := nil
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleWindowEvent: anEvent [
	
]

{ #category : #'event handling' }
BlMorphicEventHandler >> handleWindowOpened: aMorphicEvent [
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> hasPressedKey: aKey [

	^ pressedKeys includes: aKey
]

{ #category : #accessing }
BlMorphicEventHandler >> horizontalScrolling [ 

	^ HorizontalScrolling ifNil: [ HorizontalScrolling := false ]
]

{ #category : #initialization }
BlMorphicEventHandler >> initialize [

	super initialize.

	pressedKeys := Set new.
	HorizontalScrolling := false
]

{ #category : #'private - testing' }
BlMorphicEventHandler >> isClosed [

	^ windowMorph isNil
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

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> registerPressedKey: aKey [

	pressedKeys add: aKey
]

{ #category : #accessing }
BlMorphicEventHandler >> timestampNow [
	"Answer the `DateAndTime` from our space"

	^ windowMorph hostSpace space time now
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> toggleHorizontalScrolling [

	HorizontalScrolling := self horizontalScrolling not
]

{ #category : #'private - keyboard' }
BlMorphicEventHandler >> unregisterPressedKey: aKey [

	pressedKeys remove: aKey
]

{ #category : #accessing }
BlMorphicEventHandler >> window [

	^ windowMorph
]

{ #category : #accessing }
BlMorphicEventHandler >> window: aBlMorphicSpaceHostMorph [

	windowMorph := aBlMorphicSpaceHostMorph
]
