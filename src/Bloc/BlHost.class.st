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
	#category : #'Bloc-Universe - Host'
}


{ #category : #'driver selection' }
BlHost class >> isSupported [

	^ false
]

{ #category : #'driver selection' }
BlHost class >> pickHost [
	"Answer the preferred host instance."
	
	^ BlHostRegistry default preferredHost
]

{ #category : #settings }
BlHost class >> preferableHostClass [
	self
		deprecated: 'Use BlHostRegistry default preferredHost class instead'
		transformWith: '`@receiver preferableHostClass' -> 'BlHostRegistry default preferredHost class'.

	^ BlHostRegistry default preferredHost class
]

{ #category : #settings }
BlHost class >> preferableHostClass: aHostClass [
	| matchingHost |
	self
		deprecated: 'Use BlHostRegistry default preferredHost: instead'
		transformWith: '`@receiver preferableHostClass: `@arg' -> 'BlHostRegistry default preferredHost: (`@arg default)'.

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
	"Answer the supported host with the lowest priority."

	^ self supportedHostClasses first
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
			collect: [ :aHostClass | aHostClass default label -> aHostClass ]);
		description: 'Choose the option that spaces will use to open, unless they have a particular host.'.

]

{ #category : #'driver selection' }
BlHost class >> supportedHostClasses [
	"Return all supported Bloc host classes, sorted by priority (lowest first)."

	self
		deprecated: 'Use BlHostRegistry default availableHostClasses instead'
		transformWith: '`@receiver supportedHostClasses' -> 'BlHostRegistry default availableHostClasses'.

	^ BlHostRegistry default availableHostClasses
]

{ #category : #'host space - accessing' }
BlHost class >> universe [
	"Lazy initialization is preferred to avoid instantiating unused universes and background loop processes for host types that are not used in a given session."

	self
		deprecated: 'Use #default #universe instead'
		transformWith: '`@receiver universe' -> '`@receiver default universe'.

	^ self default universe
]

{ #category : #'error handling' }
BlHost >> denyPulseProcess [
	"Signal an error if the active process is the pulse loop process of this host.
	Blocking synchronization from the pulse loop process would deadlock the host loop."

	self isPulseProcessActive ifTrue: [
		self error: 'Cannot perform blocking synchronization from the pulse process as it would deadlock the host loop.' ]
]

{ #category : #testing }
BlHost >> hasUniverse [

	^ universe isNotNil
]

{ #category : #'host - testing' }
BlHost >> isPulseProcessActive [
	"Return true if the active process is the pulse loop process of this host"

	^ self subclassResponsibility
]

{ #category : #'api - lifecycle' }
BlHost >> isRunning [
	"Return true if host is initialized and running"

	^ false
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

{ #category : #enumerating }
BlHost >> pulseProcessDo: aBlock [
	"Evaluate aBlock with the running pulse Process of this host if any"

	^ self subclassResponsibility
]

{ #category : #'api - lifecycle' }
BlHost >> start [

	self subclassResponsibility
]

{ #category : #'api - lifecycle' }
BlHost >> stop [

	self subclassResponsibility
]

{ #category : #enumerating }
BlHost >> uiProcessDo: aBlock [

	self
		deprecated: 'Use #pulseProcessDo: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver pulseProcessDo: `@arg'.

	^ self pulseProcessDo: aBlock
]

{ #category : #'host space - accessing' }
BlHost >> universe [

	^ universe ifNil: [ universe := BlUniverse host: self ]
]

{ #category : #'host - testing' }
BlHost >> waitUntil: aConditionValuable timeOutIf: aTimeoutValuable onCompletion: completionBlock onTimeout: timeoutBlock [
	"Evaluate aConditionValuable repeatedly until it answers true. If aTimeoutValuable answers true first, evaluate timeoutBlock. Otherwise, evaluate completionBlock."

	^ self universe
		  waitUntil: aConditionValuable
		  timeOutIf: aTimeoutValuable
		  onCompletion: completionBlock
		  onTimeout: timeoutBlock
]

{ #category : #testing }
BlHost >> isSupported [

	^ self class isSupported
]

{ #category : #accessing }
BlHost >> priority [

	^ self class priority
]
