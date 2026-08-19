"
I am the abstract base class for Bloc Hosts. 

A host acts as a driver interface communicating with the underlying operating system and native window/rendering APIs (such as OSWindow with SDL2/SDL3, Morphic, or a headless host for testing).

Key Responsibilities:
- **Universe execution**: Manages the running loop process (thread) that pulses the universe (using subclass `BlPulseLoopHost` or custom stepping loops).
- **Space rendering and windows**: Responsible for instantiating the native windows and OS renderer for spaces (`newHostSpaceFor:`).
- **Thread/Process management**: Provides hooks to run code on the UI process (`uiProcessDo:`) and controls starting/stopping of background pulse loop processes (`start`, `stop`).
- **Synchronization**: Implements thread-safe wait loops (`waitUntil:timeout:onCompletion:onTimeout:`) to allow tests and callers to block until specific conditions or animations complete in a running host space.
"
Class {
	#name : #BlHost,
	#superclass : #Object,
	#instVars : [
		'universe'
	],
	#classVars : [
		'PreferableHostClass'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #cleanup }
BlHost class >> cleanUp [
	default := nil
]

{ #category : #accessing }
BlHost class >> default [
	^ self isSingleton
		ifTrue: [ default ifNil: [ default := self basicNew initialize; yourself ] ]
		ifFalse: [ self basicNew initialize; yourself ]
]

{ #category : #testing }
BlHost class >> hasUniverse [

	^ self isSingleton and: [ self default hasUniverse ]
]

{ #category : #'class initialization' }
BlHost class >> initialize [

	SessionManager default registerGuiClassNamed: self name
]

{ #category : #'api - lifecycle' }
BlHost class >> isRunning [
	self deprecated: 'Use default isRunning instead'.
	^ self default isRunning
]

{ #category : #testing }
BlHost class >> isSingleton [
	^ false
]

{ #category : #'driver selection' }
BlHost class >> isSupported [

	^ false
]

{ #category : #'driver selection' }
BlHost class >> label [
	"Return a human readable title to identify myself."

	^ self default label
]

{ #category : #'instance creation' }
BlHost class >> new [
	^ self isSingleton
		ifTrue: [ self default ]
		ifFalse: [ self basicNew initialize; yourself ]
]

{ #category : #'driver selection' }
BlHost class >> pickHost [
	"Answer the preferred host instance."
	
	^ BlHostRegistry default preferredHost
]

{ #category : #settings }
BlHost class >> preferableHostClass [
	self deprecated: 'Use BlHostRegistry default preferredHost class instead'.
	^ BlHostRegistry default preferredHost class
]

{ #category : #settings }
BlHost class >> preferableHostClass: aHostClass [
	| matchingHost |
	self deprecated: 'Use BlHostRegistry default preferredHost: instead'.
	matchingHost := BlHostRegistry default availableHosts 
		detect: [ :each | each class = aHostClass ]
		ifNone: [ 
			| newHost |
			newHost := aHostClass default.
			BlHostRegistry default registerHost: newHost.
			newHost ].
	BlHostRegistry default preferredHost: matchingHost
]

{ #category : #'driver selection' }
BlHost class >> prioritaryHostClass [
	"Answer either the supported host with the lowest priority, or
	`BlHeadlessHost` if there isn't any supported host."

	^ self supportedHostClasses
		ifEmpty: [ BlHeadlessHost ]
		ifNotEmpty: [ :theHostClasses | theHostClasses first ]
]

{ #category : #'driver selection' }
BlHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	A lower value is more likely to become the default host."
	
	^ self subclassResponsibility
]

{ #category : #settings }
BlHost class >> settingsOn: aBuilder [
	"Deprecated. System settings are now managed by BlHostRegistry"

	(aBuilder pickOne: #preferableHostClass)
		parent: Bloc groupSymbolForBloc;
		target: self;
		order: 1;
		label: 'Preferable host';
		domainValues: (self supportedHostClasses
			collect: [ :aHostClass | aHostClass label -> aHostClass ]);
		description: 'Choose the option that spaces will use to open, unless they have a particular host.'.

]

{ #category : #'system startup' }
BlHost class >> shutDown [
	self allSubclasses do: [ :eachHostClass |
		eachHostClass hasUniverse ifTrue: [ eachHostClass default universe stopUniverse ] ]
]

{ #category : #'api - lifecycle' }
BlHost class >> start [
	self
		deprecated: 'Use #default #start instead'
		transformWith: '`@receiver start' -> '`@receiver default start'.

	self default start
]

{ #category : #'system startup' }
BlHost class >> startUp [
	self allSubclasses do: [ :eachHostClass |
		eachHostClass hasUniverse ifTrue: [ eachHostClass default universe startUniverse ] ]
]

{ #category : #'api - lifecycle' }
BlHost class >> stop [
	self
		deprecated: 'Use #default #stop instead'
		transformWith: '`@receiver stop' -> '`@receiver default stop'.

	self default stop
]

{ #category : #'driver selection' }
BlHost class >> supportedHostClasses [
	"Return all supported Bloc host classes, sorted by priority (lowest first)."

	^ (self allSubclasses
			select: [ :aHostClass | aHostClass isSupported ])
			sort: [ :a :b | a priority < b priority ]
]

{ #category : #'api - ui process' }
BlHost class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"

	self
		deprecated: 'Use #default #uiProcessDo: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver default uiProcessDo: `@arg'.

	self default uiProcessDo: aBlock
]

{ #category : #'host space - accessing' }
BlHost class >> universe [
	"Lazy initialization is preferred to avoid instantiating unused universes and background loop processes for host types that are not used in a given session."

	self
		deprecated: 'Use #default #universe instead'
		transformWith: '`@receiver universe' -> '`@receiver default universe'.

	^ self default universe
]

{ #category : #'host - testing' }
BlHost >> canWait [
	"Return true if the active process is allowed to wait for pending work on this host"

	^ true
]

{ #category : #testing }
BlHost >> hasUniverse [

	^ universe isNotNil
]

{ #category : #'api - lifecycle' }
BlHost >> isRunning [
	"Return true if host is initialized and running"

	^ self class isRunning
]

{ #category : #'host - testing' }
BlHost >> isUIProcess [
	"Return true if the active process is the UI loop process of this host"

	^ self subclassResponsibility
]

{ #category : #accessing }
BlHost >> label [
	"Return a human readable title to identify myself."

	^ self subclassResponsibility
]

{ #category : #'host space - accessing' }
BlHost >> newHostRenderer [

	^ BlHostRenderer preferableClass new
]

{ #category : #'host - api' }
BlHost >> newHostSpaceFor: aSpace [
	"Answer a new host space"

	^ self subclassResponsibility
]

{ #category : #'paragraph - measuring' }
BlHost >> offscreenMeasureTextParagraph: aBlTextParagraph [ 
	"Update the received paragraph with its measurement."

	BlHostRenderer preferableClass offscreenMeasureTextParagraph: aBlTextParagraph
]

{ #category : #'api - lifecycle' }
BlHost >> start [

	^ self subclassResponsibility
]

{ #category : #'api - lifecycle' }
BlHost >> stop [

	^ self subclassResponsibility
]

{ #category : #enumerating }
BlHost >> uiProcessDo: aBlock [

	self class uiProcessDo: aBlock
]

{ #category : #'host space - accessing' }
BlHost >> universe [

	^ universe ifNil: [ universe := BlParallelUniverse host: self ]
]

{ #category : #'host - testing' }
BlHost >> settle: aSpace timeout: aTimeoutBlock [
	| finished |
	finished := false.
	self
		waitUntil: [ aSpace isSettled ]
		timeout: aTimeoutBlock
		onCompletion: [ finished := true ]
		onTimeout: [ finished := false ].
	^ finished
]

{ #category : #'host - testing' }
BlHost >> waitUntilTrue: aBlock timeout: aTimeoutBlock onCompletion: completionBlock onTimeout: timeoutBlock [
	"Evaluate aBlock repeatedly until it answers true. If aTimeoutBlock answers true first, evaluate timeoutBlock. Otherwise, evaluate completionBlock."

	self canWait ifFalse: [ 
		Error signal: 'Cannot wait from within the UI loop process' ].

	^ self universe
		  waitUntilTrue: aBlock
		  timeout: aTimeoutBlock
		  onCompletion: completionBlock
		  onTimeout: timeoutBlock
]
