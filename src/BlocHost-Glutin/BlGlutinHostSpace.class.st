Class {
	#name : #BlGlutinHostSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace + TGlutinEventVisitor + TBlSpaceProperties',
	#classTraits : 'TBlHostSpace classTrait + TGlutinEventVisitor classTrait + TBlSpaceProperties classTrait',
	#instVars : [
		'window',
		'mousePosition',
		'glutinRenderer',
		'eventFetcher',
		'modifiers',
		'scaleFactor'
	],
	#classVars : [
		'ZoomFactor'
	],
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #'class initialization' }
BlGlutinHostSpace class >> initialize [
	ZoomFactor := 1.0
]

{ #category : #accessing }
BlGlutinHostSpace class >> zoomFactor [
	^ ZoomFactor
]

{ #category : #accessing }
BlGlutinHostSpace class >> zoomFactor: aNumber [
	ZoomFactor := aNumber.
	
	self allSubInstancesDo: [ :eachHostSpace | eachHostSpace zoomFactorChanged ]
]

{ #category : #'host space - displaying' }
BlGlutinHostSpace >> close [
	window close
]

{ #category : #private }
BlGlutinHostSpace >> computeWindowScaleFactor: aScaleFactor [
	<return: #Number>

	^ aScaleFactor * self class zoomFactor
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
BlGlutinHostSpace >> createOpenGLSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

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

	mousePosition := FensterPhysicalPosition new.
	scaleFactor := nil.
	eventFetcher := BlHostEventFetcher hostSpace: self.
	modifiers := BlKeyModifiers new
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
	<return: #FensterLogicalSize>

	^ self physicalSize asLogical: self scaleFactor
]

{ #category : #'host space - rendering' }
BlGlutinHostSpace >> makeCurrent [
	"When displaying visual content on the screen very often a window framebuffer must be marked as a current"
	
	window makeCurrent
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
	<return: #FensterPhysicalSize>
	| anExtent |
	
	anExtent := window innerExtent.
	^ FensterPhysicalSize width: anExtent x height: anExtent y
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

	Glutin critical: [ self renderer render: self ]
]

{ #category : #'host space - geometry' }
BlGlutinHostSpace >> scaleFactor [
	"Return a scaling dpi factor from logical to physical coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Number>

	^ scaleFactor ifNil: [ scaleFactor := self computeWindowScaleFactor: window scaleFactor ]
]

{ #category : #private }
BlGlutinHostSpace >> scaleFactorChangedTo: aScaleFactor physicalSize: aFensterPhysicalSize [
	| aBlocEvent |

	scaleFactor := self computeWindowScaleFactor: aScaleFactor.

	aBlocEvent := BlSpaceScaleFactorChangedEvent new
		scaleFactor: scaleFactor;
		timestamp: DateAndTime now;
		yourself.

	self enqueueEvent: aBlocEvent.

	aBlocEvent := BlSpaceResizedEvent new
		extent: (aFensterPhysicalSize asLogical: scaleFactor) asPoint;
		timestamp: DateAndTime now;
		yourself.

	self enqueueEvent: aBlocEvent.
	self universe pulse
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

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitCharacterReceivedEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlTextInputEvent new
		text: anEvent text;
		timestamp: self space time now;
		modifiers: modifiers.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitCursorEnteredEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceMouseEnterEvent new
		timestamp: self space time now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitCursorLeftEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceMouseLeaveEvent new
		timestamp: self space time now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitCursorMovedEvent: anEvent [
	| aBlocEvent aNewCursorPosition aDelta |

	aNewCursorPosition := FensterPhysicalPosition x: anEvent x y: anEvent y.

	aDelta := aNewCursorPosition - mousePosition.

	mousePosition := aNewCursorPosition.

	aBlocEvent := BlMouseMoveEvent new
		position: (mousePosition asLogical: self scaleFactor) asPoint;
		screenPosition: window position + mousePosition asPoint;
		delta: (aDelta asLogical: self scaleFactor) asPoint;
		modifiers: modifiers;
		timestamp: self space time now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitKeyboardInputEvent: anEvent [
	| aBlocEvent aKeyboardKey aState |

	aState := anEvent state.

	aState = GlutinEventInputElementState Unknown
		ifTrue: [ ^ self ].

	aKeyboardKey := anEvent has_virtual_keycode
		ifTrue: [ self convertKeyFromEvent: anEvent ]
		ifFalse: [ BlKeyboardKey unknown: anEvent scan_code ].
	
	aBlocEvent := aState = GlutinEventInputElementState Pressed
		ifTrue: [ BlKeyDownEvent new ]
		ifFalse: [ BlKeyUpEvent new ].

	aBlocEvent
		key: aKeyboardKey;
		scanCode: anEvent scan_code;
		modifiers: modifiers;
		timestamp: self space time now.
	
	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitMainEventsCleared: anEvent [
	"| aBlocEvent |	

	aBlocEvent := BlSpaceWakeUpEvent new
		timestamp: self space time now;
		yourself.
		
	self enqueueEvent: aBlocEvent"
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitModifiersChanged: anEvent [
	modifiers := self convertKeyModifiers: anEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitMouseInputEvent: anEvent [
	| aState aBlocEvent |

	aState := anEvent state.
	
	aState = GlutinEventInputElementState Unknown
		ifTrue: [ ^ self ].

	aBlocEvent := aState = GlutinEventInputElementState Pressed
		ifTrue: [ BlMouseDownEvent new ]
		ifFalse: [BlMouseUpEvent new ].

	aBlocEvent
		position: (mousePosition asLogical: self scaleFactor) asPoint;
		screenPosition: window position + mousePosition asPoint;
		button: (self convertButton: anEvent button);
		modifiers: modifiers;
		timestamp: self space time now.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitMouseWheelEvent: anEvent [
	| aBlocEvent aDelta aScrollDistance |
		
	aDelta := anEvent delta.
	
	aScrollDistance := aDelta type = GlutinEventMouseScrollDeltaType PixelDelta
		ifTrue: [ (aDelta x @ aDelta y) / self scaleFactor ]
		ifFalse: [ aDelta type = GlutinEventMouseScrollDeltaType LineDelta
			ifTrue: [ (aDelta x @ aDelta y) * (GlutinLibrary mouseWheelScrollSpeed) ]
			ifFalse: [ 0@0 ] ].

	aScrollDistance isZero
		ifTrue: [ ^ self ].

	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: (BlVector x: aScrollDistance x y: aScrollDistance y);
		position: (mousePosition asLogical: self scaleFactor) asPoint;
		screenPosition: window position + mousePosition asPoint;
		modifiers: modifiers;
		timestamp: self space time now.
		
	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitTouchEvent: anEvent [
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitUserEvent: anEvent [
	| aBlocEvent |	

	aBlocEvent := BlSpaceWakeUpEvent new
		timestamp: self space time now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitWindowCloseRequest: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceCloseRequest new
		timestamp: self space time now;
		yourself.
		
	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitWindowDestroyed: anEvent [
]

{ #category : #'event - visiting' }
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

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitWindowMovedEvent: anEvent [
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitWindowRedrawRequested: anEvent [
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitWindowResizedEvent: anEvent [
	| aBlocEvent |
	window resize: anEvent width @ anEvent height.

	aBlocEvent := BlSpaceResizedEvent new
		extent: ((FensterPhysicalSize width: anEvent width height: anEvent height) asLogical: self scaleFactor) asPoint;
		timestamp: DateAndTime now;
		yourself.

	self enqueueEvent: aBlocEvent
]

{ #category : #'event - visiting' }
BlGlutinHostSpace >> visitWindowScaleFactorChangedEvent: anEvent [
	window resize: anEvent width @ anEvent height.

	self
		scaleFactorChangedTo: anEvent scale_factor
		physicalSize: (FensterPhysicalSize width: anEvent width height: anEvent height)
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
	window innerExtent: ((FensterLogicalSize width: anExtent x height: anExtent y) asPhysical: self scaleFactor) asPoint
]

{ #category : #private }
BlGlutinHostSpace >> zoomFactorChanged [
	self
		scaleFactorChangedTo: window scaleFactor
		physicalSize: self physicalSize
]
