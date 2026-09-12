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

	"Return early if space was never opened and host is idle"
	(self isRunning or: [ self hasSpace: aSpace ]) ifFalse: [ ^ self ].

	self defer: [ self universe closeSpace: aSpace ].
	self isRunning ifFalse: [ self start ]
]

{ #category : #'api - spaces' }
BlHost >> closeSpaces [
	"Close all spaces managed by this host."

	self hasUniverse ifTrue: [
		self universe closeSpaces.
		self stop ]
]

{ #category : #'api - ui process' }
BlHost >> defer: aValuable [
	"Enqueue a valuable from any process to be executed in the UI process at the beginning of the next pulse."

	self universe defer: aValuable
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

	^ self hasUniverse and: [ self universe hasSpace: aSpace ]
]

{ #category : #testing }
BlHost >> hasUniverse [

	^ universe isNotNil
]

{ #category : #'host - testing' }
BlHost >> isPulseProcessActive [
	"Return true if the active process is the pulse loop process of this host"

	^ false
]

{ #category : #testing }
BlHost >> isPulsing [
	"Return true if this host's universe is currently pulsing, false otherwise."

	^ self hasUniverse and: [ self universe isPulsing ]
]

{ #category : #'api - lifecycle' }
BlHost >> isRunning [
	"Return true if host is initialized and running"

	^ false
]

{ #category : #testing }
BlHost >> isSettled [
	"Return true if there are no deferred actions waiting to be executed on this host."

	^ self hasUniverse not or: [ self universe isSettled ]
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

	self defer: [ self universe openSpace: aSpace ].
	self isRunning ifFalse: [ self start ]
]

{ #category : #accessing }
BlHost >> priority [

	^ self class priority
]

{ #category : #'api - pulse' }
BlHost >> pulse [
	"Execute a single pulse cycle across all spaces managed by this host."

	self hasUniverse ifTrue: [ self universe pulse ]
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

{ #category : #'api - spaces' }
BlHost >> settle [
	"Wait until this host has executed all pending deferred actions and reached equilibrium."

	self
		waitUntil: [ self isSettled ]
		timeOutIf: [ false ]
		onCompletion: [ ]
		onTimeout: [ ]
]

{ #category : #'private - spaces' }
BlHost >> spaceDetached: aSpace [
	"A space has been detached from this host. If no spaces remain, cleanly shut down the host loop on the next frame."

	(self spaces isEmpty and: [ self isRunning ]) ifTrue: [
		self defer: [
			(self spaces isEmpty and: [ self isRunning ]) ifTrue: [
				self stop ] ] ]
]

{ #category : #'host space - accessing' }
BlHost >> spaces [
	"Answer the collection of spaces managed by this host."

	^ self universe spaces
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
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]

{ #category : #'host space - accessing' }
BlHost >> universe [

	^ universe ifNil: [ universe := BlParallelUniverse host: self ]
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
