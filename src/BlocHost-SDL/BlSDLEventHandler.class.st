Class {
	#name : #BlSDLEventHandler,
	#superclass : #Object,
	#instVars : [
		'hostSpace'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : 'BlocHost-SDL'
}

{ #category : #'as yet unclassified' }
BlSDLEventHandler >> convertButtonFromMouseEvent: aSDLMouseEvent [
	aSDLMouseEvent button = 1
		ifTrue: [ ^ BlMouseEvent primaryButton ].
	aSDLMouseEvent button = 2
		ifTrue: [ ^ BlMouseEvent middleButton ].
	aSDLMouseEvent button = 3
		ifTrue: [ ^ BlMouseEvent secondaryButton ].
	aSDLMouseEvent button = 4
		ifTrue: [ ^ 4 ].
	aSDLMouseEvent button = 5
		ifTrue: [ ^ 5 ]
]

{ #category : #'as yet unclassified' }
BlSDLEventHandler >> convertButtonFromMouseState: mouseState [
	(mouseState bitAnd: SDL_BUTTON_LMASK) ~= 0
		ifTrue: [ ^ BlMouseEvent primaryButton ].
	(mouseState bitAnd: SDL_BUTTON_MMASK) ~= 0
		ifTrue: [ ^ BlMouseEvent middleButton ].
	(mouseState bitAnd: SDL_BUTTON_RMASK) ~= 0
		ifTrue: [ ^ BlMouseEvent secondaryButton ].
	(mouseState bitAnd: SDL_BUTTON_X1MASK) ~= 0
		ifTrue: [ ^ 4 ].
	(mouseState bitAnd: SDL_BUTTON_X2MASK) ~= 0
		ifTrue: [ ^ 5 ]
]

{ #category : #'as yet unclassified' }
BlSDLEventHandler >> convertKeyModifiersFromModState: modState [ 
	| shift ctrl alt gui |
	
	shift := (modState bitAnd: KMOD_SHIFT) ~= 0.
	ctrl := (modState bitAnd: KMOD_CTRL) ~= 0.
	alt := (modState bitAnd: KMOD_LALT) ~= 0.
	gui := (modState bitAnd: KMOD_GUI) ~= 0.
	
	^ BlKeyModifiers shift: shift ctrl: ctrl alt: alt cmd: gui
]

{ #category : #'as yet unclassified' }
BlSDLEventHandler >> globalMousePosition [
	"| x y |
	x := ByteArray new: 4.
	y := ByteArray new: 4.
	SDL2 globalMouseStateX: x y: y.
	^ ( x signedLongAt: 1) @ (y signedLongAt: 1)"
	^ hostSpace position + self mousePosition
]

{ #category : #'as yet unclassified' }
BlSDLEventHandler >> globalMousePositionForEvent: anEvent [
	^ hostSpace position + (anEvent x @ anEvent y)
]

{ #category : #accessing }
BlSDLEventHandler >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlSDLEventHandler >> hostSpace: anObject [
	hostSpace := anObject
]

{ #category : #'event handling' }
BlSDLEventHandler >> mapSpecialCharacter: symbol [
	^ SDL2SpecialCharacterMapping mapKeySymbol: symbol ifAbsent: [ ^ symbol ]
]

{ #category : #'as yet unclassified' }
BlSDLEventHandler >> mousePosition [
	| x y |
	x := ByteArray new: 4.
	y := ByteArray new: 4.
	SDL2 mouseStateX: x y: y.
	^ ( x signedLongAt: 1) @ (y signedLongAt: 1)
]

{ #category : #'as yet unclassified' }
BlSDLEventHandler >> visitCommonEvent: aSDL_CommonEvent [ 
	^ BlEvent new
]

{ #category : #'as yet unclassified' }
BlSDLEventHandler >> visitFingerDownEvent: aSDL_TouchFingerDownEvent [ 
	^ BlEvent new
]

{ #category : #'as yet unclassified' }
BlSDLEventHandler >> visitFingerMotionEvent: aSDL_TouchFingerMotionEvent [ 
	^ BlEvent new
]

{ #category : #'as yet unclassified' }
BlSDLEventHandler >> visitFingerUpEvent: aSDL_TouchFingerUpEvent [ 
	^ BlEvent new
]

{ #category : #'event handling' }
BlSDLEventHandler >> visitKeyDownEvent: event [
	| keyEvent keysym |
	keysym := event keysym.
	keyEvent := BlKeyDownEvent new
		modifiers: (self convertKeyModifiersFromModState: keysym mod);
		button: (self convertButtonFromMouseState: SDL2 mouseState);
		position: self mousePosition;
		screenPosition: self globalMousePosition;
		repeat: event repeat;
		keyValue: keysym sym;
		charCode: (self mapSpecialCharacter: keysym sym);
		scanCode: keysym scancode;
		timestamp: Time millisecondClockValue.
	^ keyEvent
]

{ #category : #'event handling' }
BlSDLEventHandler >> visitKeyUpEvent: event [
	| keyEvent keysym |
	keysym := event keysym.
	keyEvent := BlKeyUpEvent new
		modifiers: (self convertKeyModifiersFromModState: keysym mod);
		button: (self convertButtonFromMouseState: SDL2 mouseState);
		position: self mousePosition;
		screenPosition: self globalMousePosition;
		repeat: event repeat;
		keyValue: keysym sym;
		charCode: (self mapSpecialCharacter: keysym sym);
		scanCode: keysym scancode;
		timestamp: Time millisecondClockValue.
	^ keyEvent
]

{ #category : #'event handling' }
BlSDLEventHandler >> visitMouseButtonDownEvent: event [
	^ BlMouseDownEvent new
		position: event x @ event y;
		screenPosition: (self globalMousePositionForEvent: event);
		modifiers: (self convertKeyModifiersFromModState: SDL2 modState);
		button: (self convertButtonFromMouseEvent: event);
		timestamp: Time millisecondClockValue
]

{ #category : #'event handling' }
BlSDLEventHandler >> visitMouseButtonUpEvent: event [
	^ BlMouseUpEvent new
		position: event x @ event y;
		screenPosition: (self globalMousePositionForEvent: event);
		modifiers: (self convertKeyModifiersFromModState: SDL2 modState);
		button: (self convertButtonFromMouseEvent: event);
		timestamp: Time millisecondClockValue
]

{ #category : #'event handling' }
BlSDLEventHandler >> visitMouseMotionEvent: event [
	
	^ BlMouseMoveEvent new
		position: event x @ event y;
		screenPosition: (self globalMousePositionForEvent: event);
		delta: event xrel @ event yrel;
		modifiers: (self convertKeyModifiersFromModState: SDL2 modState);
		"button: (self convertButtonFromMouseEvent: event);"
		timestamp: Time millisecondClockValue
]

{ #category : #'event handling' }
BlSDLEventHandler >> visitMouseWheelEvent: event [
	| vertical |
	vertical := event y.
	^ BlScrollEvent new
		modifiers: (self convertKeyModifiersFromModState: SDL2 modState);
		button: (self convertButtonFromMouseState: SDL2 mouseState);
		position: self mousePosition;
		screenPosition: self globalMousePosition;
		direction: (vertical > 0 ifTrue: [ Character arrowUp ] ifFalse: [ Character arrowDown ]);
		timestamp: Time millisecondClockValue
]

{ #category : #visiting }
BlSDLEventHandler >> visitQuitEvent: aSDL_QuitEvent [
	^ BlEvent new
]

{ #category : #'event handling' }
BlSDLEventHandler >> visitTextInputEvent: event [
	^ BlTextInputEvent new
		modifiers: (self convertKeyModifiersFromModState: SDL2 modState);
		button: (self convertButtonFromMouseState: SDL2 mouseState);
		position: self mousePosition;
		screenPosition: self globalMousePosition;
		text: (ZnUTF8Encoder new decodeBytes: event text);
		timestamp: Time millisecondClockValue
]

{ #category : #'event handling' }
BlSDLEventHandler >> visitWindowEvent: windowEvent [
	
	windowEvent event = SDL_WINDOWEVENT_EXPOSED ifTrue: [
		^ BlSpaceExposeEvent new
			timestamp: Time millisecondClockValue.
	].
	windowEvent event = SDL_WINDOWEVENT_CLOSE ifTrue: [ 
		^ BlSpaceCloseEvent new
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_MOVED ifTrue: [ 
		^ BlSpaceMoveEvent new
			timestamp: Time millisecondClockValue;
			position: self hostSpace position
	].
	windowEvent event = SDL_WINDOWEVENT_RESIZED ifTrue: [ 
		^ BlSpaceResizeEvent new
			extent: windowEvent data1 @ windowEvent data2;
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_ENTER ifTrue: [ 
		^ BlSpaceMouseEnterEvent new
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_LEAVE ifTrue: [ 
		^ BlSpaceMouseLeaveEvent new
			timestamp: Time millisecondClockValue;
			yourself
	].
	windowEvent event = SDL_WINDOWEVENT_FOCUS_GAINED ifTrue: [ 
		^ BlSpaceFocusInEvent new
			timestamp: Time millisecondClockValue;
			yourself
	].
	windowEvent event = SDL_WINDOWEVENT_FOCUS_LOST ifTrue: [ 
		^ BlSpaceFocusOutEvent new
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_MAXIMIZED ifTrue: [ 
		^ BlSpaceMaximizedEvent new
			extent: hostSpace windowExtent;
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_MINIMIZED ifTrue: [ 
		^ BlSpaceMinimizedEvent new
			extent: hostSpace windowExtent;
			timestamp: Time millisecondClockValue
	].

^ BlSpaceEvent new
	timestamp: Time millisecondClockValue
]
