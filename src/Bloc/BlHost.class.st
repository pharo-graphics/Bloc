"
I am the abstract base class for Bloc Hosts. 

A host acts as a driver interface communicating with the underlying operating system and native window/rendering APIs (such as OSWindow with SDL2/SDL3, Morphic, or a headless host for testing).

Key Responsibilities:
- **Universe execution**: Manages the running loop process (thread) that pulses the universe (using subclass `BlPulseLoopHost` or custom stepping loops).
- **Space rendering and windows**: Responsible for instantiating the native windows and OS renderer for spaces (`newHostSpaceFor:`).
- **Thread/Process management**: Provides hooks to run code on the UI process (`uiProcessDo:`) and controls starting/stopping of background pulse loop processes (`start`, `stop`).
- **Synchronization**: Implements thread-safe wait loops (`waitUntil:timeout:onCompletion:onTimeout:`) to allow tests and senders to block until specific conditions or animations complete in a running host space.
"
Class {
	#name : #BlHost,
	#superclass : #Object,
	#category : #'Bloc-Universe - Host'
}

{ #category : #'driver selection' }
BlHost class >> isSupported [

	^ false
]

{ #category : #'driver selection' }
BlHost class >> pickHost [
	self
		deprecated: 'Use Bloc preferredHost instead'
		transformWith: '`@receiver pickHost' -> 'Bloc preferredHost'.

	^ Bloc preferredHost
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

	self
		deprecated: 'Use BlHostRegistry default preferredHost class instead'
		transformWith: '`@receiver prioritaryHostClass' -> 'BlHostRegistry default preferredHost class'.

	^ BlHostRegistry default preferredHost class
]

{ #category : #'driver selection' }
BlHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	A lower value is more likely to become the default host."
	
	^ self subclassResponsibility
]

{ #category : #'driver selection' }
BlHost class >> supportedHostClasses [
	"Return all supported Bloc host classes, sorted by priority (lowest first)."

	self
		deprecated: 'Use BlHostRegistry default availableHostClasses instead'
		transformWith: '`@receiver supportedHostClasses' -> 'BlHostRegistry default availableHostClasses'.

	^ BlHostRegistry default availableHostClasses
]

{ #category : #'api - spaces' }
BlHost >> closeSpace: aSpace [
	"Close aSpace managed by this host."

	self subclassResponsibility
]

{ #category : #'api - spaces' }
BlHost >> closeSpaces [
	"Close all spaces managed by this host."

	self subclassResponsibility
]

{ #category : #'api - spaces' }
BlHost >> defer: aValuable [
	"Enqueue a valuable from any process to be executed in the host UI process at the beginning of the next pulse cycle."

	self subclassResponsibility
]

{ #category : #'error handling' }
BlHost >> denyPulseProcess [
	"Signal an error if the active process is the pulse loop process of this host.
	Blocking synchronization from the pulse loop process would deadlock the host loop."

	self isPulseProcessActive ifTrue: [
		self error: 'Cannot perform blocking synchronization from the pulse process as it would deadlock the host loop.' ]
]

{ #category : #testing }
BlHost >> hasSpace: aSpace [
	"Return true if a given space is registered with this host, false otherwise."

	^ self spaces includes: aSpace
]

{ #category : #testing }
BlHost >> hasUniverse [
	"Return true if this host uses an internal universe to coordinate spaces."

	^ false
]

{ #category : #'host - testing' }
BlHost >> isPulseProcessActive [
	"Return true if the active process is the pulse loop process of this host"

	^ false
]

{ #category : #'api - lifecycle' }
BlHost >> isRunning [
	"Return true if host is initialized and running"

	^ false
]

{ #category : #testing }
BlHost >> isSettled [
	"Return true if there are no deferred actions waiting to be executed on this host."

	^ true
]

{ #category : #testing }
BlHost >> isSpaceClosing: aSpace [
	"Return true if a given space is currently queued to be closed on this host, false otherwise."

	^ false
]

{ #category : #testing }
BlHost >> isSpaceOpening: aSpace [
	"Return true if a space is currently queued to be opened on this host, false otherwise."

	^ false
]

{ #category : #testing }
BlHost >> isSpaceSettled: aSpace [
	"Return true if there are no pending lifecycle actions for aSpace and, if opened, all its frame phases are settled."

	^ aSpace isOpened not or: [ aSpace isSettled ]
]

{ #category : #testing }
BlHost >> isSupported [

	^ self class isSupported
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

{ #category : #'api - spaces' }
BlHost >> openSpace: aSpace [
	"Open aSpace on this host."

	self subclassResponsibility
]

{ #category : #accessing }
BlHost >> priority [

	^ self class priority
]

{ #category : #'api - pulse' }
BlHost >> pulse [
	"Execute a single pulse cycle across all spaces managed by this host. Subclasses may override."
]

{ #category : #'api - pulse process' }
BlHost >> pulseProcess [
	"Return the pulse loop Process if running, or nil."

	^ nil
]

{ #category : #enumerating }
BlHost >> pulseProcessDo: aBlock [
	"Evaluate aBlock with the running pulse Process of this host if any"

	self
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver pulseProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]

{ #category : #'api - pulse' }
BlHost >> requestPulse [
	"Request a pulse cycle from this host. Subclasses with pulse loops implement this to wake the loop."

]

{ #category : #'api - lifecycle' }
BlHost >> requestStop [
	"Request the host to stop its pulse loop gracefully without terminating the active process.
	Subclasses with background loops should override to implement cooperative stopping."

]

{ #category : #'api - spaces' }
BlHost >> settle [
	"Wait until this host has executed all pending deferred actions and reached equilibrium."

	self
		waitUntil: [ self isSettled ]
		timeOutIf: [ false ]
		onCompletion: [ ]
		onTimeout: [ ]
]

{ #category : #'system startup' }
BlHost >> shutDown: isQuitting [
	"Handle system shutdown / session suspend."

	self stop
]

{ #category : #'host space - accessing' }
BlHost >> spaces [
	"Answer the collection of spaces managed by this host."

	self subclassResponsibility
]

{ #category : #'api - lifecycle' }
BlHost >> start [
	"Start background loops, workers, or native resources for this host. Subclasses may override."
]

{ #category : #'system startup' }
BlHost >> startUp: isResuming [
	"Handle system startup / session resume."

	self start
]

{ #category : #'api - lifecycle' }
BlHost >> stop [
	"Stop background loops, workers, or native resources for this host. Subclasses may override."
]

{ #category : #enumerating }
BlHost >> uiProcessDo: aBlock [

	self
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]

{ #category : #'api - spaces' }
BlHost >> waitUntil: aConditionValuable timeOutIf: aTimeoutValuable onCompletion: completionBlock onTimeout: timeoutBlock [
	"Evaluate aConditionValuable repeatedly until it answers true. If aTimeoutValuable answers true first, evaluate timeoutBlock. Otherwise, evaluate completionBlock."

	self subclassResponsibility
]
