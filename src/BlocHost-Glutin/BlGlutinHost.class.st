Class {
	#name : #BlGlutinHost,
	#superclass : #BlHost,
	#instVars : [
		'eventsSensor'
	],
	#classVars : [
		'EventsSensor',
		'HostSpaceRegistry',
		'HostSpaceRegistryMutex',
		'UIProcess',
		'UserInterruptEventHandler'
	],
	#category : #'BlocHost-Glutin'
}

{ #category : #'mutual exclusion' }
BlGlutinHost class >> critical: aBlock [
	HostSpaceRegistryMutex ifNil: [ HostSpaceRegistryMutex := Semaphore forMutualExclusion ].
	HostSpaceRegistryMutex critical: aBlock
]

{ #category : #example }
BlGlutinHost class >> example [
	| universe space |
	BlUniverse reset.

	Bloc preferableSpartaCanvas: BlSpartaSkiaCanvasBuilder.

	space := BlSpace new.
	space host: self new.
	space title: 'Glutin Window'.
	space addChild: (BlElement new
		background: Color blue;
		when: BlClickEvent do: [
			GlutinEventsFetcher shutDown: false.
			GlutinEventsFetcher startUp: false ]).
	space show
]

{ #category : #'api - ui process' }
BlGlutinHost class >> forceResumeOfUIProcess: aProcess [
	UIProcess := aProcess.
	UIProcess resume
]

{ #category : #'api - ui process' }
BlGlutinHost class >> forceStartNewUIProcess [
	UIProcess := [
		[
			BlParallelUniverse glutin pulse.
			2 milliSeconds wait
		] repeat.

	] forkAt: Processor userSchedulingPriority named: 'Bloc UI Process'
]

{ #category : #'private - windows' }
BlGlutinHost class >> hostForWindow: aWindow do: aBlock [
	self critical: [
		self spaceRegistry
			at: aWindow id
			ifPresent: aBlock ]
]

{ #category : #'class initialization' }
BlGlutinHost class >> initialize [
	EventsSensor := BlGlutinWindowEventsSensor new.
	UserInterruptEventHandler := BlGlutinUserInterruptHandler new
]

{ #category : #'host - api' }
BlGlutinHost class >> isRunning [
	<return: #Boolean>

	self uiProcessDo: [ :aUIProcess | ^ aUIProcess isTerminated not ].
	^ false
]

{ #category : #'driver selection' }
BlGlutinHost class >> isSupported [
	"Only works in headless vm"
	^ Smalltalk os windowSystemName isNil or: [ Smalltalk os windowSystemName = 'null' ]
]

{ #category : #'driver selection' }
BlGlutinHost class >> label [
	"Return a host name that we can refer to. May be used for settings"
	<return: #String>

	^ 'Glutin'
]

{ #category : #'driver selection' }
BlGlutinHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	Lower value - more likely host becomes a default"
	<return: #Number>
	
	^ 1
]

{ #category : #private }
BlGlutinHost class >> spaceRegistry [
	^ HostSpaceRegistry ifNil: [ HostSpaceRegistry := WeakIdentityValueDictionary new ]
]

{ #category : #'host - api' }
BlGlutinHost class >> start [
	self forceStartNewUIProcess.

	GlutinEventsFetcher default
		addEventHandler: UserInterruptEventHandler;
		addEventHandler: EventsSensor.
	GlutinEventsFetcher install
]

{ #category : #'host - api' }
BlGlutinHost class >> stop [
	| aUIProcess |

	aUIProcess := UIProcess.
	UIProcess := nil.
	aUIProcess ifNotNil: #terminate
]

{ #category : #'api - ui process' }
BlGlutinHost class >> terminateUIProcess [
	| aProcessToTerminate |
	
	self uiProcessDo: [ :aProcess | aProcessToTerminate := aProcess ].
	UIProcess := nil.
	aProcessToTerminate terminate
	
	"if called from UI thread nothing past this line will be executed"
]

{ #category : #'api - ui process' }
BlGlutinHost class >> uiProcessDo: aBlock [
	UIProcess ifNotNil: aBlock
]

{ #category : #example }
BlGlutinHost class >> world [
	| universe space |
	BlUniverse reset.

	Bloc preferableSpartaCanvas: BlSpartaSkiaCanvasBuilder.

	space := BlSpace new.
	space extent: 1200@800.
	space host: self new.
	space title: 'Morph World'.
	space addChild: (BlMorphicWorldEmbeddingElement new beMain).
	space show
]

{ #category : #'host - api' }
BlGlutinHost >> createHostSpaceFor: aSpace [
	"Create and assign a new oswindow host space for given bloc space"
	| aHostSpace|

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].
	
	aHostSpace := self createWindowSpaceFor: aSpace.

	aSpace hostSpace: aHostSpace
]

{ #category : #private }
BlGlutinHost >> createWindowSpaceFor: aSpace [
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space"
	| aHostSpace |

	self critical: [
		| windowBuilder windowedContext |

		GlutinEventsFetcher default ensureEventsLoop.

		windowBuilder := GlutinWindowBuilder new
			title: aSpace title;
			extent: aSpace extent;
			withDecorations: aSpace borderless not;
			withTransparency: aSpace borderless;
			withResizable: aSpace resizable;
			withMaximized: aSpace maximized;
			withFullSize: aSpace fullsize.
		
		windowedContext := GlutinEventsFetcher default eventsLoop createWindow: windowBuilder.
		
		aHostSpace := BlGlutinHostSpace new.
		aHostSpace window: windowedContext.
		
		aHostSpace universe: self universe.
		aHostSpace host: self.
		aHostSpace space: aSpace.
		aHostSpace withSpartaRenderer.
		
		self registerHostSpace: aHostSpace ].

	^ aHostSpace
]

{ #category : #'mutual exclusion' }
BlGlutinHost >> critical: aBlock [
	self class critical: aBlock
]

{ #category : #'host - api' }
BlGlutinHost >> destroyHostSpaceFor: aSpace [
	"Destroys host space window of a given space.
	Note: in most cases under 'destroy host space' we mean 'close host window' and unregister it"

	self destroyWindowSpaceFor: aSpace.

	aSpace hostSpace
		close;
		detachSpace;
		detachHost;
		detachUniverse.

	aSpace detachHostSpace
]

{ #category : #private }
BlGlutinHost >> destroyWindowSpaceFor: aSpace [
	self critical: [ self unregisterHostSpace: aSpace hostSpace ]
]

{ #category : #'host - api' }
BlGlutinHost >> isRunning [
	"Return true if host is initialized and running"
	<return: #Boolean>

	^ self class isRunning
]

{ #category : #'host - testing' }
BlGlutinHost >> isStillAvailable [
	"Let's assume that a space is opened with me as a host.
	I return true if I am still available host for the current system.
	For example if a space is opened in a native window with a headless VM
	and then reopened with a headfull VM all those spaces should be re-opened
	with a different host, for example morphic"
	<return: #Boolean>

	^ self class isSupported
]

{ #category : #'event - handling' }
BlGlutinHost >> processGlutinEvent: aGlutinEvent [
	<return: #GlutinControlFlow>
	| aMappedEvent aWindowId |
		
	aMappedEvent := aGlutinEvent mapped.

	aMappedEvent isWindowEvent
		ifTrue: [
			aWindowId := aGlutinEvent window_id asInteger.
			self spaceRegistry
				at: aWindowId
				ifPresent: [ :aHostSpace | aMappedEvent accept: aHostSpace ] ].

	aMappedEvent isCommonEvent
		ifTrue: [ aMappedEvent accept: self ].

	^ GlutinControlFlow poll
]

{ #category : #initialize }
BlGlutinHost >> registerHostSpace: aHostSpace [
	self spaceRegistry at: aHostSpace window id put: aHostSpace
]

{ #category : #private }
BlGlutinHost >> spaceRegistry [
	^ self class spaceRegistry
]

{ #category : #'host - api' }
BlGlutinHost >> start [
	self class start
]

{ #category : #'host - api' }
BlGlutinHost >> stop [
	self class stop
]

{ #category : #'host - testing' }
BlGlutinHost >> supportsBufferSurface [
	"Return true if this host can work with buffer surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #'host - testing' }
BlGlutinHost >> supportsOpenGLSurface [
	"Return true if this host can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ OSPlatform current isWindows not
]

{ #category : #initialize }
BlGlutinHost >> unregisterHostSpace: aHostSpace [
	self spaceRegistry
		removeKey: aHostSpace window id
		ifAbsent: [  ]
]

{ #category : #'event - handling' }
BlGlutinHost >> visitEventsCleared: anEvent [
	| aBlocEvent |

	aBlocEvent := BlUniverseEventsCleared new
		timestamp: BlTime real now.
		
	self universe dispatchEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlGlutinHost >> visitLoopDestroyed: anEvent [
]

{ #category : #'event - handling' }
BlGlutinHost >> visitNewEvents: anEvent [
	| aBlocEvent |

	aBlocEvent := BlUniverseEventsArrived new
		timestamp: BlTime real now.
		
	self universe dispatchEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlGlutinHost >> visitResumed: anEvent [
	| aBlocEvent |

	aBlocEvent := BlUniverseResumed new
		timestamp: BlTime real now.
		
	self universe dispatchEvent: aBlocEvent
]

{ #category : #'event - handling' }
BlGlutinHost >> visitSuspended: anEvent [
	| aBlocEvent |

	aBlocEvent := BlUniverseSuspended new
		timestamp: BlTime real now.
		
	self universe dispatchEvent: aBlocEvent
]
