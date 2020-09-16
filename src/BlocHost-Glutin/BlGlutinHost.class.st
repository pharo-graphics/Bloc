Class {
	#name : #BlGlutinHost,
	#superclass : #BlHost,
	#classVars : [
		'EventsSensor',
		'HostSpaceRegistry',
		'HostSpaceRegistryMutex',
		'PulseLoop',
		'UserInterruptEventHandler'
	],
	#classInstVars : [
		'hdpiRenderer'
	],
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #'api - ui process' }
BlGlutinHost class >> forceResumeOfUIProcess: aProcess [
	PulseLoop forceStartOfUIProcess: aProcess
]

{ #category : #'api - ui process' }
BlGlutinHost class >> forceStartNewUIProcess [
	PulseLoop forceStartNewUIProcess
]

{ #category : #accessing }
BlGlutinHost class >> hdpiRenderer [
	^ hdpiRenderer ifNil: [ false ]
]

{ #category : #accessing }
BlGlutinHost class >> hdpiRenderer: aBoolean [
	hdpiRenderer := aBoolean
]

{ #category : #'private - windows' }
BlGlutinHost class >> hostForWindow: aWindow do: aBlock [
	| aHost |
	
	aHost := HostSpaceRegistryMutex critical: [
		self spaceRegistry
			at: aWindow id
			ifAbsent: [ nil ] ].
	
	aHost ifNotNil: aBlock
]

{ #category : #'class initialization' }
BlGlutinHost class >> initialize [
	PulseLoop := BlHostPulseLoop forHost: self.
	EventsSensor := BlGlutinWindowEventsSensor new.
	UserInterruptEventHandler := GlutinUserInterruptHandler new uiProcessBlock: [
		| process |
		process := nil.
		self uiProcessDo: [ :aUIProcess | process := aUIProcess ].
		process ].
	HostSpaceRegistryMutex := Mutex new
]

{ #category : #'api - lifecycle' }
BlGlutinHost class >> isRunning [
	<return: #Boolean>

	^ PulseLoop isRunning
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

{ #category : #preferences }
BlGlutinHost class >> preferencesOn: aBuilder [
	<systemsettings>
			
	(aBuilder setting: #hdpiRenderer)
		parent: #Bloc;
		order: 10;
		target: self;
		label: 'Glutin - HDPI';
		description: 'Enable HDPI Morphic Renderer';
		default: [ true ]
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
	^ HostSpaceRegistry ifNil: [ HostSpaceRegistry := WeakValueDictionary new ]
]

{ #category : #'api - lifecycle' }
BlGlutinHost class >> start [
	PulseLoop start.

	GlutinEventsFetcher default
		addEventHandler: UserInterruptEventHandler;
		addEventHandler: EventsSensor.
	GlutinEventsFetcher install
]

{ #category : #'api - lifecycle' }
BlGlutinHost class >> stop [
	GlutinEventsFetcher default
		removeEventHandler: UserInterruptEventHandler;
		removeEventHandler: EventsSensor.
	PulseLoop stop
]

{ #category : #'api - ui process' }
BlGlutinHost class >> uiProcessDo: aBlock [
	PulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #'host - api' }
BlGlutinHost >> createHostSpaceFor: aSpace [
	"Create and assign a new oswindow host space for given bloc space"
	| aHostSpace |

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
	| aHostSpace  windowBuilder windowedContext |

	windowBuilder := GlutinWindowBuilder new
		title: aSpace title;
		extent: aSpace extent;
		withDecorations: aSpace borderless not;
		withTransparency: aSpace borderless;
		withResizable: aSpace resizable;
		withMaximized: aSpace maximized;
		withFullSize: aSpace fullsize.
	
	windowedContext := GlutinEventsFetcher default eventLoop createWindow: windowBuilder.
	aSpace knowsPosition
		ifTrue: [ windowedContext position: aSpace position ].
	
	aHostSpace := BlGlutinHostSpace new.
	aHostSpace window: windowedContext.
	
	aHostSpace universe: self universe.
	aHostSpace host: self.
	aHostSpace space: aSpace.
	aHostSpace withSpartaRenderer.
	
	self registerHostSpace: aHostSpace.

	^ aHostSpace
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
	self unregisterHostSpace: aSpace hostSpace
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

{ #category : #'host - api' }
BlGlutinHost >> openMorphicWorld [
	self class hdpiRenderer
		ifTrue: [ GlutinWorldSpartaRenderer openMorphicWorld ]
		ifFalse: [ GlutinWorldOpenGLRenderer openMorphicWorld ]
]

{ #category : #initialize }
BlGlutinHost >> registerHostSpace: aHostSpace [
	HostSpaceRegistryMutex critical: [ self spaceRegistry at: aHostSpace window id put: aHostSpace ]
]

{ #category : #private }
BlGlutinHost >> spaceRegistry [
	^ self class spaceRegistry
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
	
	^ true
]

{ #category : #initialize }
BlGlutinHost >> unregisterHostSpace: aHostSpace [
	HostSpaceRegistryMutex critical: [ self spaceRegistry
		removeKey: aHostSpace window id
		ifAbsent: [  ] ]
]
