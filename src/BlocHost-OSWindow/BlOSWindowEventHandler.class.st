Class {
	#name : #BlOSWindowEventHandler,
	#superclass : #OSWindowGestureHandler,
	#instVars : [
		'window',
		'time'
	],
	#classVars : [
		'SymbolCharacterMapping'
	],
	#pools : [
		'OSKeySymbols'
	],
	#category : #'BlocHost-OSWindow-Support'
}

{ #category : #'as yet unclassified' }
BlOSWindowEventHandler class >> initialize [
	"
	self initialize
	"
	super initialize.
	SymbolCharacterMapping := Dictionary new.
	{
	 OSK_RETURN . Character cr.
	 OSK_BACKSPACE . Character backspace.
	 OSK_TAB . Character tab.
	 OSK_HOME . Character home.
	 OSK_LEFT . Character arrowLeft.
	 OSK_UP . Character arrowUp.
	 OSK_RIGHT . Character arrowRight.
	 OSK_DOWN . Character arrowDown.
	 OSK_END . Character end.
	 OSK_INSERT . Character insert.
	 OSK_PAGEUP . Character pageUp.
	 OSK_PAGEDOWN . Character pageDown.
	 OSK_DELETE. Character delete.
	
	 OSK_KP_0 . $0.
	 OSK_KP_1 . $1.
	 OSK_KP_2 . $2.
	 OSK_KP_3 . $3.
	 OSK_KP_4 . $4.
	 OSK_KP_5 . $5.
	 OSK_KP_6 . $6.
	 OSK_KP_7 . $7.
	 OSK_KP_8 . $8.
	 OSK_KP_9 . $9.
	 OSK_KP_DIVIDE . $/.
	 OSK_KP_MULTIPLY . $*.
	 OSK_KP_PLUS . $+.
	 OSK_KP_MINUS . $-.
	 OSK_KP_ENTER . Character cr.
	 OSK_KP_PERIOD . $..
	} pairsDo: [ :key :val | SymbolCharacterMapping at: key put: val charCode ]
]

{ #category : #'as yet unclassified' }
BlOSWindowEventHandler class >> window: aWin [
	^ self new
		window: aWin;
		yourself
]

{ #category : #converting }
BlOSWindowEventHandler >> convertButton: osButton [
	<return: #BlMouseButton>

	osButton = 1 ifTrue: [ ^ BlMouseButton primary ].
	osButton = 2 ifTrue: [ ^ BlMouseButton middle ].
	osButton = 3 ifTrue: [ ^ BlMouseButton secondary ].

	^ BlMouseButton code: osButton
]

{ #category : #converting }
BlOSWindowEventHandler >> convertKeyModifiers: modifiers [
	<return: #BlKeyModifiers>

	^ BlKeyModifiers
		shift: modifiers shift
		ctrl: modifiers ctrl
		alt: modifiers alt
		cmd: modifiers cmd
]

{ #category : #converting }
BlOSWindowEventHandler >> convertModifiers: modifiers [
	| buttons |
	buttons := 0.
	
	"Alt/Option key"
	modifiers alt ifTrue: [
		"On windows and unix, treat alt key as command key"
		buttons := Smalltalk os isWin32 | Smalltalk os isUnix
			ifTrue: [ buttons | 2r01000000 ]
			ifFalse: [ buttons | 2r00100000 ]
	]. 
	
	modifiers ctrl ifTrue: [ buttons := buttons | 2r00010000 ]. "Control key"
	modifiers shift ifTrue: [ buttons := buttons | 8 ]. "Shift key"
	modifiers cmd ifTrue: [ buttons := buttons | 2r01000000 ]. "Cmd key"
	
	modifiers buttons button1 ifTrue:  [ buttons := buttons | MouseButtonEvent redButton ].
	modifiers buttons button2 ifTrue:  [ buttons := buttons | MouseButtonEvent blueButton ].
	modifiers buttons button3 ifTrue:  [ buttons := buttons | MouseButtonEvent yellowButton ].
	^ buttons
]

{ #category : #actions }
BlOSWindowEventHandler >> enqueue: anEvent [
	self window enqueueEvent: anEvent
]

{ #category : #events }
BlOSWindowEventHandler >> handleEvent: anEvent [
	anEvent accept: self
]

{ #category : #initialization }
BlOSWindowEventHandler >> initialize [
	super initialize.
	
	time := BlTime real.
	
	self registerGesture: OSTouchTwoFingersScrollDetector new.
	self registerGesture: OSTouchTwoFingersPinchDetector new.
]

{ #category : #converting }
BlOSWindowEventHandler >> mapSymbolToKeyValue: symbol [
	^ SymbolCharacterMapping at: symbol ifAbsent: [
		 "Don't allow symbol values outside the unicode range"
		 symbol >= 16r400000 ifTrue: [ 0 ] ifFalse: [ symbol ] ]
]

{ #category : #'api - accessing' }
BlOSWindowEventHandler >> time [
	<return: #BlTime>
	
	^ time
]

{ #category : #'api - accessing' }
BlOSWindowEventHandler >> time: aTime [	
	time := aTime
]

{ #category : #'visiting keyboard' }
BlOSWindowEventHandler >> visitKeyDownEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlKeyDownEvent new
		key: (Key value: (self mapSymbolToKeyValue: anEvent symbol));
		scanCode: anEvent scanCode;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: DateAndTime now;
		position: anEvent position;
		screenPosition: window position + anEvent position.

	NonInteractiveTranscript stdout show: aBlocEvent; cr.

	self enqueue: aBlocEvent
]

{ #category : #'visiting keyboard' }
BlOSWindowEventHandler >> visitKeyUpEvent: anEvent [
	| aBlocEvent |

	NonInteractiveTranscript stdout
		show: 'scanCode = ', anEvent scanCode asString;
		show: 'symbol = ', anEvent symbol asString;
		show: 'character = ', anEvent character asString;
		cr.

	aBlocEvent := BlKeyUpEvent new
		key: (Key value: (self mapSymbolToKeyValue: anEvent symbol));
		scanCode: anEvent scanCode;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: DateAndTime now;
		position: anEvent position;
		screenPosition: window position + anEvent position.
	
	NonInteractiveTranscript stdout show: aBlocEvent; cr.

	self enqueue: aBlocEvent
]

{ #category : #'visiting - mouse' }
BlOSWindowEventHandler >> visitMouseButtonPressEvent: anEvent [
	| aBlocEvent |
	
	"we handle touch events separately, therefore ignore `touch` based mouse events"
	"anEvent isTouch
		ifTrue: [ ^ self ]."

	aBlocEvent := BlMouseDownEvent new
		position: anEvent position;
		screenPosition: window position + anEvent position;
		delta: anEvent delta;
		button: (self convertButton: anEvent button);
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: self time now.

	self enqueue: aBlocEvent
]

{ #category : #'visiting - mouse' }
BlOSWindowEventHandler >> visitMouseButtonReleaseEvent: anEvent [
	| aBlocEvent |
	
	"we handle touch events separately, therefore ignore `touch` based mouse events"
	"anEvent isTouch
		ifTrue: [ ^ self ]."

	aBlocEvent := BlMouseUpEvent new
		position: anEvent position;
		screenPosition: window position + anEvent position;
		delta: anEvent delta;
		button: (self convertButton: anEvent button);
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: self time now.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting - mouse' }
BlOSWindowEventHandler >> visitMouseMoveEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlMouseMoveEvent new
		position: anEvent position;
		screenPosition: window position + anEvent position;
		delta: anEvent delta;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: self time now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting - mouse' }
BlOSWindowEventHandler >> visitMouseWheelEvent: anEvent [
	| vertical horizontal aBlocEvent |
	
	NonInteractiveTranscript stdout show: (anEvent); cr.
	
	horizontal := anEvent scrollHorizontal.
	vertical := anEvent scrollVertical.
	
	(horizontal isZero and: [ vertical isZero ])
		ifTrue: [ ^ self ].
		
	NonInteractiveTranscript stdout show: (anEvent); cr.
	
	aBlocEvent := BlMouseWheelEvent new
		vector: (BlVector x: horizontal negated y: vertical);
		position: anEvent position;
		screenPosition: window position + anEvent position;
		direction: (vertical > 0 ifTrue: [Character arrowUp] ifFalse: [Character arrowDown]);
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: DateAndTime now.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting keyboard' }
BlOSWindowEventHandler >> visitTextInputEvent: anEvent [
	| aBlocEvent |
	
	anEvent logCr.
	
	anEvent text
		ifNil: [ ^ self ].
	
	aBlocEvent := BlTextInputEvent new
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		text: anEvent text;
		timestamp: DateAndTime now.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting - touch' }
BlOSWindowEventHandler >> visitTouchActionPointerDownEvent: anEvent [
	| aBlocEvent |
	
	true ifTrue: [ ^ self ].
	
	aBlocEvent := BlTouchDownEvent new
		position: window windowExtent * anEvent position;
		screenPosition: window position + (window windowExtent * anEvent position);
		delta: window windowExtent * anEvent delta;
		timestamp: DateAndTime now;
		pointerId: anEvent fingerId;
		pressure: anEvent pressure;
		yourself.
	
	self enqueue: aBlocEvent
]

{ #category : #'visiting - touch' }
BlOSWindowEventHandler >> visitTouchActionPointerMoveEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlTouchMoveEvent new
		position: window windowExtent * anEvent position;
		screenPosition: window position + (window windowExtent * anEvent position);
		delta: window windowExtent * anEvent delta;
		timestamp: DateAndTime now;
		pointerId: anEvent fingerId;
		pressure: anEvent pressure;
		yourself.

	self enqueue: aBlocEvent
]

{ #category : #'visiting - touch' }
BlOSWindowEventHandler >> visitTouchActionPointerUpEvent: anEvent [
	| aBlocEvent |

	true ifTrue: [ ^ self ].

	aBlocEvent := BlTouchUpEvent new
		position: window windowExtent * anEvent position;
		screenPosition: window position + (window windowExtent * anEvent position);
		delta: window windowExtent * anEvent delta;
		timestamp: DateAndTime now;
		pointerId: anEvent fingerId;
		pressure: anEvent pressure;
		yourself.

	self enqueue: aBlocEvent
]

{ #category : #'visiting - gestures' }
BlOSWindowEventHandler >> visitTouchTwoFingersPinchBeginEvent: anEvent [
	"anEvent inspect"
]

{ #category : #'visiting - gestures' }
BlOSWindowEventHandler >> visitTouchTwoFingersPinchMoveEvent: anEvent [
	| aBlocEvent |

	true ifTrue: [ ^ self ].

	aBlocEvent := BlGesturePinchEvent new
		distance: anEvent dDist;
		position: anEvent position;
		screenPosition: window position + anEvent position;
		delta: anEvent delta;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: self time now;
		yourself.

	self enqueue: aBlocEvent
]

{ #category : #'visiting - gestures' }
BlOSWindowEventHandler >> visitTouchTwoFingersScrollBeginEvent: anEvent [
	anEvent logCr.
]

{ #category : #visiting }
BlOSWindowEventHandler >> visitUnknownEvent: anEvent [
	Transcript
		show: 'Unknown event: ';
		show: anEvent data printString;
		cr
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> visitWindowCloseEvent: anEvent [
	| aBlocEvent |
	anEvent suppressDefaultAction.

	aBlocEvent := BlSpaceCloseRequest new
		timestamp: self time now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> visitWindowExposeEvent: anEvent [
	self flag: 'ToDo: Make dirty the exposed area.'.
	^ nil
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> visitWindowFocusInEvent: anEvent [
	^ BlSpaceFocusInEvent new
		timestamp: DateAndTime now;
		yourself
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> visitWindowFocusOutEvent: anEvent [
	^ BlSpaceFocusOutEvent new
		timestamp: DateAndTime now;
		yourself
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> visitWindowMaximizedEvent: anEvent [
	^ self windowResized: anEvent window extent
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> visitWindowMinimizedEvent: anEvent [
	^ self windowResized: anEvent window extent
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> visitWindowMouseEnterEvent: anEvent [
	^ BlSpaceMouseEnterEvent new
		timestamp: DateAndTime now;
		yourself
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> visitWindowMouseLeaveEvent: anEvent [
	^ BlSpaceMouseLeaveEvent new
		timestamp: DateAndTime now;
		yourself
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> visitWindowMoveEvent: anEvent [
	^ BlSpaceMovedEvent new
		timestamp: DateAndTime now;
		position: self window position;
		yourself
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> visitWindowResizeEvent: anEvent [
	^ self windowResized: anEvent width @ anEvent height
]

{ #category : #'api - accessing' }
BlOSWindowEventHandler >> window [
	<return: #BlOSWindowSpace>

	^ window
]

{ #category : #'api - accessing' }
BlOSWindowEventHandler >> window: aBlOSWindowSpace [
	window := aBlOSWindowSpace
]

{ #category : #'visiting window' }
BlOSWindowEventHandler >> windowResized: aPoint [
	^ BlSpaceResizedEvent new
		extent: aPoint;
		timestamp: DateAndTime now;
		yourself
]
