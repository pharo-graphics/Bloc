Class {
	#name : #BlGlutinHost,
	#superclass : #BlHost,
	#classVars : [
		'CurrentSession',
		'EventsLoop',
		'HostSpaceRegistry',
		'HostSpaceRegistryMutex',
		'IsRunning'
	],
	#category : #'BlocHost-Glutin'
}

{ #category : #example }
BlGlutinHost class >> example [
	| universe space |
	BlUniverse reset.

	Bloc preferableSpartaCanvas: BlSpartaSkiaCanvasBuilder.

	space := BlSpace new.
	space host: self new.
	space title: 'Glutin Window'.
	space addChild: GtWorld new.
	space show
]

{ #category : #'driver selection' }
BlGlutinHost class >> isSupported [
	^ true
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

{ #category : #'host - api' }
BlGlutinHost >> createHostSpaceFor: aSpace [
	"Create and assign a new oswindow host space for given bloc space"
	| aHostSpace|

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].
	
	aHostSpace := self createWindowSpaceFor: aSpace.
	aHostSpace universe: self universe.
	aHostSpace host: self.
	aHostSpace space: aSpace.
	aHostSpace withSpartaRenderer.

	aSpace hostSpace: aHostSpace
]

{ #category : #private }
BlGlutinHost >> createWindowSpaceFor: aSpace [
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space"
	| aHostSpace |

	self critical: [
		| windowBuilder windowedContext |

		self ensureEventsLoop.

		windowBuilder := GlutinWindowBuilder new
			title: aSpace title;
			extent: aSpace extent;
			withDecorations: aSpace borderless not;
			withTransparency: aSpace borderless;
			withResizable: aSpace resizable;
			withMaximized: aSpace maximized.
		
		windowedContext := GlutinWindowedContext
			create: EventsLoop
			windowBuilder: windowBuilder.
		
		aHostSpace := BlGlutinHostSpace new.
		aHostSpace window: windowedContext.

		self spaceRegistry at: windowedContext id put: aHostSpace ].

	^ aHostSpace
]

{ #category : #'mutual exclusion' }
BlGlutinHost >> critical: aBlock [
	HostSpaceRegistryMutex ifNil: [ HostSpaceRegistryMutex := Semaphore forMutualExclusion ].
	HostSpaceRegistryMutex critical: aBlock
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
	self critical: [
		self spaceRegistry
			removeKey: aSpace hostSpace id
			ifAbsent: [  ] ].
]

{ #category : #'event - handling' }
BlGlutinHost >> ensureEventsLoop [
	"I make sure that Glutin events loop (external) is valid"

	(CurrentSession == Smalltalk session
		and: [ EventsLoop isNotNil
			and: [ EventsLoop isNull not ] ])
		ifTrue: [ ^ self ].

	CurrentSession := Smalltalk session.
	EventsLoop := GlutinEventsLoop new
]

{ #category : #'host - api' }
BlGlutinHost >> isRunning [
	"Return true if host is initialized and running"
	<return: #Boolean>

	^ IsRunning ifNil: [ false ]
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

{ #category : #private }
BlGlutinHost >> spaceRegistry [
	^ HostSpaceRegistry ifNil: [ HostSpaceRegistry := WeakIdentityValueDictionary new ]
]

{ #category : #'host - api' }
BlGlutinHost >> start [

	self isRunning
		ifTrue: [ ^ self ].

	IsRunning := true.	
	[ EventsLoop run: [ :aGlutinEvent |
		| aControlFlow |
		aControlFlow := self processGlutinEvent: aGlutinEvent.
		self isRunning
			ifFalse:  [ GlutinControlFlow exit ]
			ifTrue: [ aControlFlow ] ] ] forkAt: Processor userSchedulingPriority - 1 named: 'Bloc Process'
]

{ #category : #'host - api' }
BlGlutinHost >> stop [
	IsRunning := false
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
	
	^ false
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
