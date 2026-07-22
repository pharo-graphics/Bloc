"
I am the abstract class for a Host.
I define an environment that can be used to provide actual screen spaces and rendering.
A Host can be compared to a driver that communicates with the native multimedia API.

"
Class {
	#name : #BlHost,
	#superclass : #Object,
	#classInstVars : [
		'universe'
	],
	#classVars : [
		'PreferableHostClass'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #testing }
BlHost class >> hasUniverse [

	^ universe isNotNil
]

{ #category : #'class initialization' }
BlHost class >> initialize [

	SessionManager default registerGuiClassNamed: self name
]

{ #category : #'system startup' }
BlHost class >> startUp [
	self allSubclasses do: [ :eachHostClass |
		eachHostClass hasUniverse ifTrue: [ eachHostClass universe startUniverse ] ]
]

{ #category : #'system startup' }
BlHost class >> shutDown [
	self allSubclasses do: [ :eachHostClass |
		eachHostClass hasUniverse ifTrue: [ eachHostClass universe stopUniverse ] ]
]

{ #category : #cleanup }
BlHost class >> cleanUp [
	universe := nil
]

{ #category : #'api - lifecycle' }
BlHost class >> isRunning [
	^ self subclassResponsibility
]

{ #category : #'driver selection' }
BlHost class >> isSupported [

	^ false
]

{ #category : #'driver selection' }
BlHost class >> label [
	"Return a human readable title to identify myself."

	^ self subclassResponsibility
]

{ #category : #'driver selection' }
BlHost class >> pickHost [
	"Answer a new instance of the preferable host."
	
	^ self preferableHostClass new
]

{ #category : #settings }
BlHost class >> preferableHostClass [

	^ PreferableHostClass ifNil: [
		PreferableHostClass := self prioritaryHostClass ]
]

{ #category : #settings }
BlHost class >> preferableHostClass: aHostClass [
	
	PreferableHostClass := aHostClass

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
	<systemsettings>

	(aBuilder pickOne: #preferableHostClass)
		parent: Bloc groupSymbolForBloc;
		target: self;
		order: 1;
		label: 'Preferable host';
		domainValues: (self supportedHostClasses
			collect: [ :aHostClass | aHostClass label -> aHostClass ]);
		description: 'Choose the option that spaces will use to open, unless they have a particular host.'.

]

{ #category : #'api - lifecycle' }
BlHost class >> start [

	self subclassResponsibility
]

{ #category : #'api - lifecycle' }
BlHost class >> stop [

	self subclassResponsibility
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
]

{ #category : #'host space - accessing' }
BlHost class >> universe [
	"Lazy initialization is preferred to avoid instantiating unused universes and background loop processes for host types that are not used in a given session."

	^ universe ifNil: [ universe := BlParallelUniverse new hostClass: self; yourself ]
]

{ #category : #'api - lifecycle' }
BlHost >> isRunning [
	"Return true if host is initialized and running"

	^ self class isRunning
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

	self class start
]

{ #category : #'api - lifecycle' }
BlHost >> stop [

	self class stop
]

{ #category : #enumerating }
BlHost >> uiProcessDo: aBlock [

	self class uiProcessDo: aBlock
]

{ #category : #'host space - accessing' }
BlHost >> universe [
	
	^ self class universe
]

{ #category : #'host - testing' }
BlHost >> waitPendingWorkFor: aSpace timeout: aTimeoutBlock [
	| finished |
	finished := false.
	self
		waitUntil: [ aSpace hasPendingWork not ]
		timeout: aTimeoutBlock
		onCompletion: [ finished := true ]
		onTimeout: [ finished := false ].
	^ finished
]

{ #category : #'host - testing' }
BlHost >> waitUntil: aBlock timeout: aTimeoutBlock onCompletion: completionBlock onTimeout: timeoutBlock [
	"Evaluate aBlock repeatedly until it answers true. If aTimeoutBlock answers true first, evaluate timeoutBlock. Otherwise, evaluate completionBlock."
	| aSemaphore |
	aSemaphore := Semaphore new.
	self universe registerPulseSemaphore: aSemaphore.
	
	[
		[ aBlock value ] whileFalse: [
			aTimeoutBlock value ifTrue: [ ^ timeoutBlock value ].
			self isRunning
				ifTrue: [
					"Reactive wait: Wakes up instantly on the next pulse"
					aSemaphore waitTimeoutMilliseconds: 50 ]
				ifFalse: [
					"No background loop, or we are on the UI process itself: manually run cycle and yield a tiny bit"
					self universe pulse.
					(Delay forMilliseconds: 1) wait ] ]
	] ensure: [
		self universe unregisterPulseSemaphore: aSemaphore ].
		
	^ completionBlock value
]
