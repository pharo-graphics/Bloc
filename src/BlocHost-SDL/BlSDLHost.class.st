Class {
	#name : #BlSDLHost,
	#superclass : #BlHost,
	#instVars : [
		'hostSpaces',
		'eventHandler',
		'inputSemaphore',
		'isRunning'
	],
	#classVars : [
		'EventLoopProcess'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : 'BlocHost-SDL'
}

{ #category : #testing }
BlSDLHost class >> hasPlugin [
	"<primitive: #primitiveHasDisplayPlugin module: #SDL2DisplayPlugin>"
	^ false
]

{ #category : #'driver selection' }
BlSDLHost class >> isSupported [
	^ false
]

{ #category : #'driver selection' }
BlSDLHost class >> label [
	^ 'SDL2'
]

{ #category : #'driver selection' }
BlSDLHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	Lower value - more likely host becomes a default"
	<return: #Number>
	
	^ 20
]

{ #category : #'private - event' }
BlSDLHost >> convertEvent: anSDLEvent hostSpace: anHostSpace [
	eventHandler hostSpace: anHostSpace.
	^ anSDLEvent accept: eventHandler
]

{ #category : #'host - api' }
BlSDLHost >> createHostSpaceFor: aSpace [
	"Create and assign a new sdl host space for given bloc space"
	| aWindow aHostSpace|
	
	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].
		
	aWindow := self createSDLWindowFor: aSpace.

	aHostSpace := BlSDLSpace new 
		host: self;
		sdlWindow: aWindow.

	SkiaCanvas isSupported
		"Use OpenGL if available"
		ifTrue: [ aHostSpace withSkiaRendereer ]
		ifFalse: [ aHostSpace withSpartaRenderer ].

	self registerHostSpace: aHostSpace.
	aSpace hostSpace: aHostSpace
]

{ #category : #private }
BlSDLHost >> createSDLWindowFor: aSpace [
	"Note, that I use given space only to find out what window
	properties (flag) to use for created window.
	I do not create any strong or weak references to provided space"
	| flags sdlWindow x y |

	flags := aSpace isVisible
		ifTrue: [ SDL_WINDOW_SHOWN ]
		ifFalse: [ SDL_WINDOW_HIDDEN ].

	aSpace fullscreen
		ifTrue: [ flags := flags | SDL_WINDOW_FULLSCREEN_DESKTOP ].
	aSpace borderless
		ifTrue: [ flags := flags | SDL_WINDOW_BORDERLESS ].
	
	flags := flags | SDL_WINDOW_ALLOW_HIGHDPI.
		
	SDL2 glSetAttribute: SDL_GL_RED_SIZE value: 8.
	SDL2 glSetAttribute: SDL_GL_BLUE_SIZE value: 8.
	SDL2 glSetAttribute: SDL_GL_GREEN_SIZE value: 8.
	SDL2 glSetAttribute: SDL_GL_ALPHA_SIZE value: 8.
	SDL2 glSetAttribute: SDL_GL_DEPTH_SIZE value: 0.
	SDL2 glSetAttribute: SDL_GL_STENCIL_SIZE value: 8.
	SDL2 glSetAttribute: SDL_GL_DOUBLEBUFFER value: 1.
	SDL2 glSetAttribute: SDL_GL_ACCELERATED_VISUAL value: 1.
	
	flags := flags | SDL_WINDOW_OPENGL.
	
	"Get the actual initial position value."
	x := aSpace position x.
	y := aSpace position y.
	"attributes windowCentered ifTrue: [
		x := SDL_WINDOWPOS_CENTERED.
		y := SDL_WINDOWPOS_CENTERED ]."

	"Extra creation flags"
	aSpace resizable ifTrue: [ 
		flags := flags | SDL_WINDOW_RESIZABLE ].

	aSpace maximized ifTrue: [ 
		flags := flags | SDL_WINDOW_MAXIMIZED ].
	
	aSpace minimized ifTrue: [ 
		flags := flags | SDL_WINDOW_MINIMIZED ].

	"Create the window"
	sdlWindow := SDL2 createWindow: aSpace title
		x: x
		y: y
		width: aSpace width 
		height: aSpace height 
		flags: flags.
	
	^ sdlWindow
]

{ #category : #'host - api' }
BlSDLHost >> destroyHostSpaceFor: aSpace [
	| aWindowID |

	self
		assert: [ aSpace hasHostSpace ]
		description: [ 'Space must have a host!' ].
	
	aWindowID := aSpace hostSpace windowID.
	aSpace hostSpace close.
	self unregisterHostSpace: aWindowID.
	aSpace detachHostSpace
]

{ #category : #'private - event loop' }
BlSDLHost >> eventLoopProcessWithPlugin [
	| event session semaIndex |
	event := SDL_Event new.
	session := Smalltalk session.
	
	[
		semaIndex := Smalltalk registerExternalObject: inputSemaphore.
		self primSetupInputSemaphore: semaIndex.
	
		[ inputSemaphore
			wait;
			consumeAllSignals.
		session == Smalltalk session ]
			whileTrue: [
				[ (SDL2 pollEvent: event) > 0 ]
					whileTrue: [ self processEvent: event ] ]

	] ensure: [ Smalltalk unregisterExternalObject: inputSemaphore ]
]

{ #category : #'private - event loop' }
BlSDLHost >> eventLoopProcessWithoutPlugin [
	| event session |

	event := SDL_Event new.
	session := Smalltalk session.
	
	[ session == Smalltalk session ] whileTrue: [
		[ (SDL2 pollEvent: event) > 0 ]
			whileTrue: [ self processEvent: event ].

		(Delay forMilliseconds: 5) wait ]
]

{ #category : #initialization }
BlSDLHost >> initialize [
	super initialize.
	
	inputSemaphore := Semaphore new.
	
	hostSpaces := nil. "initialized in #start"
	eventHandler := nil "initialized in #start".
	isRunning := false
]

{ #category : #'host - api' }
BlSDLHost >> isRunning [
	"Return true if host in already running"
	<return: #Boolean>

	^ isRunning
]

{ #category : #private }
BlSDLHost >> primSetupInputSemaphore: semaIndex [
	<primitive: #primitiveSetSDL2Input module: #SDL2DisplayPlugin>
	self primitiveFailed
]

{ #category : #'private - event' }
BlSDLHost >> processCommonEvent: aMappedEvent [

	hostSpaces valuesDo: [ :aHostSpace |
		| aBlocEvent |
		aBlocEvent := self convertEvent: aMappedEvent hostSpace: aHostSpace.
		aHostSpace enqueueEvent: aBlocEvent ]
]

{ #category : #'private - event' }
BlSDLHost >> processEvent: sdlEvent [
	| aMappedEvent |
	
	aMappedEvent := sdlEvent mapped.
	"events without windowID should be handled by all windows"
	aMappedEvent windowID
		ifNil: [ self processCommonEvent: aMappedEvent ]
		ifNotNil: [ self processWindowEvent: aMappedEvent ]
]

{ #category : #'private - event' }
BlSDLHost >> processWindowEvent: aMappedEvent [
	| aBlocEvent aHostSpace |

	aHostSpace := hostSpaces
		at: aMappedEvent windowID
		ifAbsent: [ "window with unknown id, ignore it" ^ self ].

	aBlocEvent := self
		convertEvent: aMappedEvent
		hostSpace: aHostSpace.

	aHostSpace enqueueEvent: aBlocEvent
]

{ #category : #'private - host space' }
BlSDLHost >> registerHostSpace: aBlSDLSpace [

	self
		assert: [ aBlSDLSpace isNotNil ]
		description: [ 'Host space must not be nil' ].
	
	self
		assert: [ (hostSpaces includesKey: aBlSDLSpace windowID) not ]
		description: [ 'Host space with id: ', aBlSDLSpace windowID asString, ' is already registered' ].

	hostSpaces
		at: aBlSDLSpace windowID
		put: aBlSDLSpace
]

{ #category : #'private - event loop' }
BlSDLHost >> setupEventLoop [
	"Create and start an loop for SDL2 events"
	
	self
		assert: [ EventLoopProcess isNil ]
		description: [ 'Event loop must not exist!' ].

	EventLoopProcess := (self class hasPlugin
		ifTrue: [ [ self eventLoopProcessWithPlugin ]  ]
		ifFalse: [ [ self eventLoopProcessWithoutPlugin ] ])
			forkAt: Processor lowIOPriority
			named: 'BlocHost SDL2 EventLoop'
]

{ #category : #'host - api' }
BlSDLHost >> start [

	self
		assert: [ self isRunning not ]
		description: [ 'SDL host must not be running!' ].

	hostSpaces := Dictionary new. "(windowId -> BlSDLSpaceL)"
	eventHandler := BlSDLEventHandler new.
	self setupEventLoop.
	isRunning := true
]

{ #category : #'host - api' }
BlSDLHost >> stop [

	self
		assert: [ hostSpaces isNotNil and: [ hostSpaces isEmpty ] ]
		description: [ 'Can not stop SDL host with registered spaces!' ].
	
	self
		assert: [ self isRunning ]
		description: [ 'SDL host must be running in order to be stopped' ].

	self stopEventLoop.
	hostSpaces := nil.
	eventHandler := nil.
	isRunning := false
]

{ #category : #'private - event loop' }
BlSDLHost >> stopEventLoop [
	"Terminate and destroy SDL2 event loop"
	
	self
		assert: [ EventLoopProcess isNotNil ]
		description: [ 'Event loop must exist!' ].

	EventLoopProcess terminate.
	EventLoopProcess := nil.
	Smalltalk unregisterExternalObject: inputSemaphore
]

{ #category : #'private - host space' }
BlSDLHost >> unregisterHostSpace: aWindowID [

	self
		assert: [ hostSpaces includesKey: aWindowID ]
		description: [ 'Host space with id: ', aWindowID asString, ' is not registered' ].

	hostSpaces removeKey: aWindowID
]
