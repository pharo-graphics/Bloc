"
I am a OSWindow event handler for Bloc host spaces.
"
Class {
	#name : #BlOSWindowEventHandler,
	#superclass : #OSWindowGestureHandler,
	#instVars : [
		'window',
		'time',
		'keyboardKeyTable'
	],
	#pools : [
		'OSKeySymbols'
	],
	#category : #'BlocHost-OSWindow-Support'
}

{ #category : #'instance creation' }
BlOSWindowEventHandler class >> new [

	self error: 'Use #window: instead'
]

{ #category : #'instance creation' }
BlOSWindowEventHandler class >> window: anOSWindow [

	^ self basicNew
		initialize;
		window: anOSWindow;
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
BlOSWindowEventHandler >> convertKeyFromEvent: anEvent [
	<return: #KeyboardKey>

	^ self keyboardKeyTable keyFromVirtualCode: anEvent symbol
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

{ #category : #actions }
BlOSWindowEventHandler >> enqueue: anEvent [
	self window enqueueEvent: anEvent
]

{ #category : #'visiting - window' }
BlOSWindowEventHandler >> enqueueSpaceResized: aPoint [

	| aBlocEvent |
	aBlocEvent := BlSpaceResizedEvent new
		extent: aPoint;
		timestamp: time now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting - window' }
BlOSWindowEventHandler >> enqueueSpaceResized: aBlSpaceResizedEvent extent: aPoint [

	aBlSpaceResizedEvent
		extent: aPoint;
		timestamp: time now.
		
	self enqueue: aBlSpaceResizedEvent
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
	self registerGesture: OSTouchTwoFingersPinchDetector new
]

{ #category : #'api - accessing' }
BlOSWindowEventHandler >> keyboardKeyTable [
	^ keyboardKeyTable
]

{ #category : #'api - accessing' }
BlOSWindowEventHandler >> keyboardKeyTable: aKeyboardKeyTable [
	keyboardKeyTable := aKeyboardKeyTable
]

{ #category : #'api - accessing' }
BlOSWindowEventHandler >> time [

	^ time
]

{ #category : #'api - accessing' }
BlOSWindowEventHandler >> time: aBlTime [

	time := aBlTime
]

{ #category : #'visiting - keyboard' }
BlOSWindowEventHandler >> visitKeyDownEvent: anEvent [

	| aBlEvent |
	aBlEvent := BlKeyDownEvent new
		key: (self convertKeyFromEvent: anEvent);
		scanCode: anEvent scanCode;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: time now;
		yourself.

	self enqueue: aBlEvent
]

{ #category : #'visiting - keyboard' }
BlOSWindowEventHandler >> visitKeyUpEvent: anEvent [

	| aBlEvent |
	aBlEvent := BlKeyUpEvent new
		key: (self convertKeyFromEvent: anEvent);
		scanCode: anEvent scanCode;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: time now;
		yourself.

	self enqueue: aBlEvent
]

{ #category : #'visiting - universe' }
BlOSWindowEventHandler >> visitMainEventsCleared: anEvent [
	self window space pulse.
	3 milliSeconds wait.
	

	
]

{ #category : #'visiting - mouse' }
BlOSWindowEventHandler >> visitMouseButtonPressEvent: anEvent [

	| aBlocEvent button |
	"we handle touch events separately, therefore ignore `touch` based mouse events"
	"anEvent isTouch
		ifTrue: [ ^ self ]."
	button := self convertButton: anEvent button.
	aBlocEvent := button mouseDownEventClass new
		position: anEvent position;
		screenPosition: window position + anEvent position;
		delta: anEvent delta;
		button: button;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: time now;
		yourself.

	self enqueue: aBlocEvent
]

{ #category : #'visiting - mouse' }
BlOSWindowEventHandler >> visitMouseButtonReleaseEvent: anEvent [

	| aBlocEvent button |
	"we handle touch events separately, therefore ignore `touch` based mouse events"
	"anEvent isTouch
		ifTrue: [ ^ self ]."
	button := self convertButton: anEvent button.
	aBlocEvent := button mouseUpEventClass new
		position: anEvent position;
		screenPosition: window position + anEvent position;
		delta: anEvent delta;
		button: button;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: time now;
		yourself.
		
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
		timestamp: time now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting - mouse' }
BlOSWindowEventHandler >> visitMouseWheelEvent: anEvent [

	| vertical horizontal aBlocEvent |
	horizontal := anEvent scrollHorizontal.
	vertical := anEvent scrollVertical.
	
	(horizontal isZero and: [ vertical isZero ])
		ifTrue: [ ^ self ].
	
	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: (BlVector x: horizontal y: vertical);
		position: anEvent position;
		screenPosition: window position + anEvent position;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: time now;
		yourself.
	
	self enqueue: aBlocEvent
]

{ #category : #'visiting - keyboard' }
BlOSWindowEventHandler >> visitTextInputEvent: anEvent [

	| aBlocEvent |
	anEvent text ifNil: [ ^ self ].
	
	aBlocEvent := BlTextInputEvent new
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		text: anEvent text;
		timestamp: time now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting - touch' }
BlOSWindowEventHandler >> visitTouchActionPointerDownEvent: anEvent [

]

{ #category : #'visiting - touch' }
BlOSWindowEventHandler >> visitTouchActionPointerMoveEvent: anEvent [

]

{ #category : #'visiting - touch' }
BlOSWindowEventHandler >> visitTouchActionPointerUpEvent: anEvent [

]

{ #category : #'visiting - gestures' }
BlOSWindowEventHandler >> visitTouchTwoFingersPinchBeginEvent: anEvent [

]

{ #category : #'visiting - gestures' }
BlOSWindowEventHandler >> visitTouchTwoFingersPinchMoveEvent: anEvent [

]

{ #category : #'visiting - gestures' }
BlOSWindowEventHandler >> visitTouchTwoFingersScrollBeginEvent: anEvent [
]

{ #category : #'visiting - gestures' }
BlOSWindowEventHandler >> visitTouchTwoFingersScrollMoveEvent: anEvent [

]

{ #category : #visiting }
BlOSWindowEventHandler >> visitUnknownEvent: anEvent [
	Transcript
		show: 'Unknown event: ';
		show: anEvent data printString;
		cr
]

{ #category : #'visiting - window' }
BlOSWindowEventHandler >> visitWindowCloseEvent: anEvent [

	| aBlocEvent |
	anEvent suppressDefaultAction.

	aBlocEvent := BlSpaceCloseRequest new
		timestamp: time now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting - window' }
BlOSWindowEventHandler >> visitWindowExposeEvent: anEvent [
	self flag: 'ToDo: Make dirty the exposed area.'.
	^ nil
]

{ #category : #'visiting - window' }
BlOSWindowEventHandler >> visitWindowFocusInEvent: anEvent [

	| aBlocEvent |
	aBlocEvent := BlSpaceFocusInEvent new
		timestamp: time now;
		yourself.

	self enqueue: aBlocEvent
]

{ #category : #'visiting - window' }
BlOSWindowEventHandler >> visitWindowFocusOutEvent: anEvent [

	| aBlocEvent |
	aBlocEvent := BlSpaceFocusOutEvent new
		timestamp: time now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : #visiting }
BlOSWindowEventHandler >> visitWindowMaximizedEvent: anEvent [

	self
		enqueueSpaceResized: BlSpaceMaximizedEvent new
		extent: anEvent window extent
]

{ #category : #visiting }
BlOSWindowEventHandler >> visitWindowMinimizedEvent: anEvent [

	self
		enqueueSpaceResized: BlSpaceMinimizedEvent new
		extent: anEvent window extent
]

{ #category : #'visiting - window' }
BlOSWindowEventHandler >> visitWindowMouseEnterEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceMouseEnterEvent new
		timestamp: DateAndTime now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting - window' }
BlOSWindowEventHandler >> visitWindowMouseLeaveEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceMouseLeaveEvent new
		timestamp: DateAndTime now;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : #'visiting - window' }
BlOSWindowEventHandler >> visitWindowMoveEvent: anEvent [
	| aBlocEvent |

	aBlocEvent := BlSpaceMovedEvent new
		timestamp: DateAndTime now;
		position: self window position;
		yourself.
		
	self enqueue: aBlocEvent
]

{ #category : #visiting }
BlOSWindowEventHandler >> visitWindowResizeEvent: anEvent [

	self
		enqueueSpaceResized: BlSpaceResizedEvent new
		extent: anEvent width @ anEvent height
]

{ #category : #'api - accessing' }
BlOSWindowEventHandler >> window [
	<return: #BlOSWindowHostSpace>

	^ window
]

{ #category : #'api - accessing' }
BlOSWindowEventHandler >> window: aBlOSWindowSpace [
	window := aBlOSWindowSpace
]
