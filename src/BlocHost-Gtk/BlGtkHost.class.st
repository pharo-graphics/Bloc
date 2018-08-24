"
I am a concrete implementation of a BlHost that allows users to open host bloc spaces within Gtk3 windows
"
Class {
	#name : #BlGtkHost,
	#superclass : #BlHost,
	#instVars : [
		'hostSpaces',
		'eventHandler',
		'isRunning'
	],
	#classVars : [
		'EventLoopProcess'
	],
	#category : 'BlocHost-Gtk'
}

{ #category : #'driver selection' }
BlGtkHost class >> label [
	^ 'Gtk3'
]

{ #category : #'driver selection' }
BlGtkHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	Lower value - more likely host becomes a default"
	<return: #Number>
	
	^ 25
]

{ #category : #'private - event' }
BlGtkHost >> convertEvent: aGtkEvent hostSpace: anHostSpace [
	eventHandler hostSpace: anHostSpace.
	aGtkEvent accept: eventHandler
]

{ #category : #private }
BlGtkHost >> createGtkWindowFor: aSpace [
	| win |
	win := GtkWindow primNew: GtkWindowType GTK_WINDOW_TOPLEVEL.
	win primSetEvents: GdkEventMask GDK_ALL_EVENTS_MASK value.
	win primRealize.
	win primSetAppPaintable: true.
	^ win
]

{ #category : #'host - api' }
BlGtkHost >> createHostSpaceFor: aSpace [
	| aWindow aHostSpace|
	
	self
		assert: [ aSpace hasHost not ]
		description: [ 'Space must not have a host!' ].
	
	aWindow := self createGtkWindowFor: aSpace.
	aHostSpace := BlGtkSpace new 
		hostWindow: aWindow;
		withSpartaRendereer.
		
	self registerHostSpace: aHostSpace.
	aSpace hostSpace: aHostSpace
]

{ #category : #'host - api' }
BlGtkHost >> destroyHostSpaceFor: aSpace [
	| aWindowID |

	self
		assert: [ aSpace hasHost ]
		description: [ 'Space must have a host!' ].
	
	aWindowID := aSpace hostSpace windowID.
	aSpace hostSpace close.
	self unregisterHostSpace: aWindowID.
	aSpace hostSpace: nil
]

{ #category : #'private - event loop' }
BlGtkHost >> eventLoopProcess [
	| event aGdkEventFunc session |
	session := Smalltalk session.
	
	aGdkEventFunc := GdkEventFunc on: [ :evtPtr :data |
		event := (GdkEvent fromHandle: evtPtr).
		self processEvent: event.
		Gtk primMainDoEvent: event.].
	
	Gdk eventHandlerSet: aGdkEventFunc data: nil notify: nil.
	
	[ session == Smalltalk session] whileTrue: [
		Gtk primEventsPending 
			ifTrue: [ Gtk primMainIterationDo: false. ]
			ifFalse: [ (Delay forMilliseconds: 5) wait ]
	]
]

{ #category : #initialization }
BlGtkHost >> initialize [
	super initialize.
	isRunning := false.
	hostSpaces := nil. "initialized in #start"
	eventHandler := nil "initialized in #start"
]

{ #category : #'host - api' }
BlGtkHost >> isRunning [
	"Return true if host in already running"
	<return: #Boolean>

	^ isRunning
]

{ #category : #'private - event' }
BlGtkHost >> processCommonEvent: aGdkEvent [
	hostSpaces valuesDo: [ :aHostSpace | 
		self convertEvent: aGdkEvent hostSpace: aHostSpace ]
]

{ #category : #'private - event' }
BlGtkHost >> processEvent: aGdkEvent [
	| aMappedEvent |
	aMappedEvent := aGdkEvent mapped.
	"events without windowID should be handled by all windows"
	aMappedEvent windowID
		ifNil: [ self processCommonEvent: aMappedEvent ]
		ifNotNil: [ self processWindowEvent: aMappedEvent ].
	BlUniverse default requestNextPulse
]

{ #category : #'private - event' }
BlGtkHost >> processWindowEvent: aGdkEvent [
	| aHostSpace |

	aHostSpace := hostSpaces
		at: aGdkEvent windowID
		ifAbsent: [ "window with unknown id, ignore it" ^ self ].

	self
		convertEvent: aGdkEvent
		hostSpace: aHostSpace.

]

{ #category : #'private- host space' }
BlGtkHost >> registerHostSpace: anHostSpace [

	self
		assert: [ anHostSpace isNotNil ]
		description: [ 'Host space must not be nil' ].
	
	self
		assert: [ (hostSpaces includesKey: anHostSpace windowID) not ]
		description: [ 'Host space with id: ', anHostSpace windowID asString, ' is already registered' ].

	hostSpaces
		at: anHostSpace windowID 
		put: anHostSpace
]

{ #category : #'private - event loop' }
BlGtkHost >> setupEventLoop [
	"Create and start an loop for Gtk events"

	self
		assert: [ EventLoopProcess isNil ]
		description: [ 'Event loop must not exist!' ].
		
	EventLoopProcess := [ self eventLoopProcess ]
		forkAt: Processor lowIOPriority
		named: 'BlocHost SDL2 EventLoop'.
	
]

{ #category : #'host - api' }
BlGtkHost >> start [
	
	self
		assert: [ self isRunning not ]
		description: [ 'Gtk host must not be running!' ].

	hostSpaces := Dictionary new. "(windowId -> BlGtkSpace)"
	eventHandler := BlGtkEventHandler new.
	Gtk primInit.
	self setupEventLoop.
	isRunning := true.
	
	

]

{ #category : #'host - api' }
BlGtkHost >> stop [
	
	self
		assert: [ hostSpaces isNotNil and: [ hostSpaces isEmpty ] ]
		description: [ 'Can not stop Gtk host with registered spaces!' ].
	
	self
		assert: [ self isRunning ]
		description: [ 'Gtk host must be running in order to be stopped' ].

	self stopEventLoop.
	Gtk primMainQuit.
	
	hostSpaces := nil.
	eventHandler := nil.
	isRunning := false.
]

{ #category : #'private - event loop' }
BlGtkHost >> stopEventLoop [
|aGdkEventFunc|
	"Terminate and destroy Gtk event loop"
	
	self
		assert: [ EventLoopProcess isNotNil ]
		description: [ 'Event loop must exist!' ].

	EventLoopProcess terminate.
	EventLoopProcess := nil.
	
	"re-plug the default gdk event handler"
	aGdkEventFunc := GdkEventFunc on: [ :evtPtr :data |
		Gtk primMainDoEvent: (GdkEvent fromHandle: evtPtr).].
	Gdk eventHandlerSet: aGdkEventFunc data: nil notify: nil.
]

{ #category : #'private- host space' }
BlGtkHost >> unregisterHostSpace: aWindowID [
	self
		assert: [ hostSpaces includesKey: aWindowID ]
		description: [ 'Host space with id: ', aWindowID asString, ' is not registered' ].

	hostSpaces removeKey: aWindowID
]
