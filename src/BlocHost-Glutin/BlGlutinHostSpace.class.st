Class {
	#name : #BlGlutinHostSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace',
	#classTraits : 'TBlHostSpace classTrait',
	#instVars : [
		'window',
		'mousePosition',
		'lastModifiers',
		'glutinRenderer',
		'eventFetcher'
	],
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #'host space - displaying' }
BlGlutinHostSpace >> close [
	window close
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> convertButton: aGlutinButton [
	<return: #BlMouseButton>

	aGlutinButton button_type = GlutinEventMouseButtonType Left
		ifTrue: [ ^ BlMouseButton primary ].

	aGlutinButton button_type = GlutinEventMouseButtonType Middle
		ifTrue: [ ^ BlMouseButton middle ].

	aGlutinButton button_type = GlutinEventMouseButtonType Right
		ifTrue: [ ^ BlMouseButton secondary ].

	^ BlMouseButton code: aGlutinButton button_code
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> convertKeyFromEvent: anEvent [
	<return: #BlKeyboardKey>

	^ self keyboardKeyTable keyFromVirtualCode: anEvent virtual_keycode
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> convertKeyModifiers: theGlutinModifiers [
	<return: #BlKeyModifiers>

	^ BlKeyModifiers
		shift: theGlutinModifiers shift
		ctrl: theGlutinModifiers ctrl
		alt: theGlutinModifiers alt
		cmd: theGlutinModifiers logo
]

{ #category : #initialization }
BlGlutinHostSpace >> createBufferSurfaceRenderer [
	<return: #TBlSurfaceRenderer>
	
	^ BlGlutinBufferSurfaceRenderer new window: self window
]

{ #category : #initialization }
BlGlutinHostSpace >> createOpenGLSurfaceRenderer [
	<return: #TBlSurfaceRenderer>

	^ BlGlutinOpenGLSurfaceRenderer new window: self window
]

{ #category : #'host space - cursor' }
BlGlutinHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"

	window cursor: aCursor asGlutinCursor
]

{ #category : #'host space - geometry' }
BlGlutinHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ 96.0
]

{ #category : #'host space - events' }
BlGlutinHostSpace >> enqueueEvent: aBlEvent [
	"I put events in a queue to be processed later"

	self eventFetcher enqueueEvent: aBlEvent
]

{ #category : #'host space - accessing' }
BlGlutinHostSpace >> eventFetcher [
	"Return event fetcher used to enqueue events that should be
	processed in the beginning of every frame"
	<return: #BlHostEventFetcher>

	^ eventFetcher
]

{ #category : #'host space - events' }
BlGlutinHostSpace >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
	
	self eventFetcher fetchedEventsDo: aBlock
]

{ #category : #'host space - accessing' }
BlGlutinHostSpace >> id [
	^ window id
]

{ #category : #initialization }
BlGlutinHostSpace >> initialize [
	super initialize.

	mousePosition := 0@0.
	eventFetcher := BlHostEventFetcher new
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> keyboardKeyTable [
	^ BlGlutinKeyboardKeyTable default
]

{ #category : #'host space - geometry' }
BlGlutinHostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."
	<return: #BlHostLogicalSize>
	| anExtent |
	
	anExtent := window innerExtent.
	^ BlHostLogicalSize width: anExtent x height: anExtent y
]

{ #category : #'host space - testing' }
BlGlutinHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"
	<return: #Boolean>
	
	^ window isValid not
]

{ #category : #'host space - geometry' }
BlGlutinHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."
	<return: #BlHostPhysicalSize>
	| anExtent |
	
	anExtent := window framebufferExtent.
	^ BlHostPhysicalSize width: anExtent x height: anExtent y
]

{ #category : #'host space - geometry' }
BlGlutinHostSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ window position
]

{ #category : #'host space - geometry' }
BlGlutinHostSpace >> position: aPoint [
	"Change window's position to a given point in screen coordinates"
	
	window position: aPoint

]

{ #category : #'host space - rendering' }
BlGlutinHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	Glutin critical: [
		window makeCurrent.
		self renderer render: aSpace ]
]

{ #category : #'host space - displaying' }
BlGlutinHostSpace >> show [
	"Window appears when created, show is redundant"
]

{ #category : #'window - properties' }
BlGlutinHostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ window title
]

{ #category : #'window - properties' }
BlGlutinHostSpace >> title: aString [
	"Change window's title"

	window title: aString
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitCharacterReceivedEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlTextInputEvent new
		text: anEvent text;
		timestamp: self space time now.
	
	lastModifiers
		ifNotNil: [ aBlocEvent modifiers: lastModifiers ].

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitCursorMovedEvent: anEvent [
	| aBlocEvent aNewCursorPosition aDelta |

	aNewCursorPosition := anEvent x @ anEvent y.
	aDelta := mousePosition
		ifNil: [ 0@0 ]
		ifNotNil: [ aNewCursorPosition - mousePosition ].

	mousePosition := aNewCursorPosition.

	aBlocEvent := BlMouseMoveEvent new
		position: mousePosition;
		screenPosition: window position + mousePosition;
		delta: aDelta;
		modifiers: (lastModifiers := self convertKeyModifiers: anEvent modifiers);
		timestamp: self space time now;
		yourself.
		
	self enqueueEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitKeyboardInputEvent: anEvent [
	| aBlocEvent aState |

	anEvent has_virtual_keycode
		ifFalse: [ ^ self ].

	mousePosition
		ifNil: [ mousePosition := 0@0 ].

	aState := anEvent state.

	aState = GlutinEventInputElementState Unknown
		ifTrue: [ ^ self ].
	
	aBlocEvent := aState = GlutinEventInputElementState Pressed
		ifTrue: [ BlKeyDownEvent new ]
		ifFalse: [ BlKeyUpEvent new ].
		
	aBlocEvent
		key: (self convertKeyFromEvent: anEvent);
		scanCode: anEvent scan_code;
		modifiers: (lastModifiers := self convertKeyModifiers: anEvent modifiers);
		timestamp: self space time now;
		position: mousePosition;
		screenPosition: window position + mousePosition.
	
	self enqueueEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitMouseInputEvent: anEvent [
	| aState aBlocEvent |
	
	"cursor position is unknown, we can not properly handle mouse input event, therefore ignore it"
	mousePosition
		ifNil: [ ^ self ].

	aState := anEvent state.
	
	aState = GlutinEventInputElementState Unknown
		ifTrue: [ ^ self ].

	aBlocEvent := aState = GlutinEventInputElementState Pressed
		ifTrue: [ BlMouseDownEvent new ]
		ifFalse: [BlMouseUpEvent new ].

	aBlocEvent
		position: mousePosition;
		screenPosition: window position + mousePosition;
		button: (self convertButton: anEvent button);
		modifiers: (lastModifiers := self convertKeyModifiers: anEvent modifiers);
		timestamp: self space time now.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitMouseWheelEvent: anEvent [
	| aBlocEvent aDelta aScrollDistance |

	mousePosition
		ifNil: [ ^ self ].
		
	aDelta := anEvent delta.
	
	aScrollDistance := aDelta type = GlutinEventMouseScrollDeltaType PixelDelta
		ifTrue: [ aDelta x negated @ aDelta y ]
		ifFalse: [ aDelta type = GlutinEventMouseScrollDeltaType LineDelta
			ifTrue: [ (aDelta x negated @ aDelta y) * (GlutinLibrary mouseWheelScrollSpeed) ]
			ifFalse: [ 0@0 ] ].
		
	aScrollDistance isZero
		ifTrue: [ ^ self ].
	
	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: (BlVector x: aScrollDistance x y: aScrollDistance y);
		position: mousePosition;
		screenPosition: window position + mousePosition;
		modifiers: (lastModifiers := self convertKeyModifiers: anEvent modifiers);
		timestamp: self space time now.
		
	self enqueueEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitTouchEvent: anEvent [
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitWindowCloseRequest: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceCloseRequest new
		timestamp: self space time now;
		yourself.
		
	self enqueueEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitWindowDestroyed: anEvent [
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitWindowFocusedEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := anEvent is_focused
		ifTrue: [ BlSpaceFocusInEvent new ]
		ifFalse: [ BlSpaceFocusOutEvent new ].

	aBlocEvent
		timestamp: self space time now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitWindowMovedEvent: anEvent [
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitWindowRedrawRequested: anEvent [
]

{ #category : #'event - handling' }
BlGlutinHostSpace >> visitWindowResizedEvent: anEvent [
	| aBlocEvent |
	window resize: anEvent width @ anEvent height.

	aBlocEvent := BlSpaceResizedEvent new
		extent: anEvent width @ anEvent height;
		timestamp: DateAndTime now;
		yourself.

	self enqueueEvent: aBlocEvent.
	self universe pulse
]

{ #category : #accessing }
BlGlutinHostSpace >> window [
	<return: #GlutinWindowedContext>

	^ window
]

{ #category : #accessing }
BlGlutinHostSpace >> window: aGlutinWindowedContext [
	window := aGlutinWindowedContext
]

{ #category : #'host space - geometry' }
BlGlutinHostSpace >> windowExtent: anExtent [
	window innerExtent: anExtent
]
