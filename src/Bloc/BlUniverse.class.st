"
I am the lowest level in Bloc.
My responsibility is to manage the low-level services such as managing windows, event queue and the drawing synchronization. 

My main responsibility is to manage and to keep in sync the opened Spaces.

I am the interface used to create/delete window.
To achieve that, i use the notion of Host (see: BlHost).

Users can choose a preferable host. In order to do that a universe must be stopped first.
Example:

universe stop.
universe preferableHost: MyHost new.
universe start.
"
Class {
	#name : #BlUniverse,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'pulseLoop',
		'preferableHost',
		'pulseListeners',
		'spaceManager',
		'announcer',
		'deferredActions',
		'nextPulseRequested'
	],
	#classVars : [
		'Default',
		'Session'
	],
	#category : 'Bloc-Universe'
}

{ #category : #accessing }
BlUniverse class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : #'deferred message' }
BlUniverse class >> defer: aBlock [
	self default defer: aBlock
]

{ #category : #accessing }
BlUniverse class >> reset [
	Default ifNotNil: [
		[
			Default spaceManager spaces do: [ :aSpace | aSpace close ].
			Default isRunning ifTrue: [ Default stop ].
			Default preferableHost ifNotNil: [ :aHost | aHost stop ].
			Default preferableHost: nil
		]
			"This is hard reset, so we have to ignore all errors, just print them"
			on: Error do: [ :e | e logCr ] ].
	Default := nil
]

{ #category : #'pulse managing' }
BlUniverse >> addPulseListener: anObject [
	pulseListeners add: anObject.
	announcer subscribe: BlPulseEvent send: #pulse to: anObject
]

{ #category : #enumerating }
BlUniverse >> allSpacesDo: aBlock [
	"Evaluate a block with every space managed by space manager as argument"

	self spaceManager spaces do: aBlock
]

{ #category : #accessing }
BlUniverse >> animationManager [
	self 
		deprecated: 'Use BlElement>>#addAnimation:'
		on: 	'2 April 2018' 
		in: 'Pharo-6.0-60539-'.
		
	^ nil
]

{ #category : #asserting }
BlUniverse >> assertStopped [
]

{ #category : #'window managing' }
BlUniverse >> closeSpaceWindow: aSpace [

	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must not be nil' ].

	self
		assert: [ aSpace hasHostSpace ]
		description: [ 'Space must have a host! Are you sure it is opened?' ].

	"First destroy host space and "
	aSpace host destroyHostSpaceFor: aSpace.

	"then remove space itself from space manager"
	self spaceManager removeSpace: aSpace.
	
	"Notify root element that it is no longer in scene graph"
	aSpace root dispatchRemovedFromSceneGraph.
	"Send space closed event.
	Note: a new space may be spawned as a reaction to the event, that is why
	we send it before stopping host and universe"
	aSpace dispatchEvent: (BlSpaceClosedEvent new space: self).
	
	(self spaceManager spaces anySatisfy: [ :eachSpace | eachSpace host == aSpace host ])
		ifFalse: [ aSpace host isRunning ifTrue: [ aSpace host stop ] ].

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Host space must not have a host!' ].
		
	"Stop universe if there are no spaces left"
	self spaceManager hasSpaces
		ifFalse: [ self stop ]
]

{ #category : #'initialize-release' }
BlUniverse >> defaultPulseLoop [
	^ BlPulseLoop new
]

{ #category : #'deferred actions' }
BlUniverse >> defer: aValuable [
	"#defer: can be used from any thread to execute a valuable in the GUI thread
	You can use it to update the GUI states from any other thread.
	The valuable will be evaluated as soon as possible."

	deferredActions nextPut: aValuable.
	self pulseLoop isRunning
		ifTrue: [ self requestNextPulse ]
]

{ #category : #'pulse managing' }
BlUniverse >> firePulse: aPulseEvent [
	[  
		nextPulseRequested := false.
		announcer announce: aPulseEvent.
		self spaceManager pulse.
		self tryToRunDeferredActions.
	] on: Error do: [ :err | 
		"It is critical, that event handling keeps running despite errors.
		Normally, any errors in event handling requires immediate attention and fixing"
		err freeze.
		[ err debug ] fork.
	 ]
]

{ #category : #accessing }
BlUniverse >> host [
	^ preferableHost ifNil: [ BlHost pickHost ]
]

{ #category : #'initialize-release' }
BlUniverse >> initialize [
	super initialize.
	announcer := Announcer new.
	deferredActions := WaitfreeQueue new.
	pulseListeners := OrderedCollection new.
	pulseLoop := self defaultPulseLoop.
	nextPulseRequested :=true.
	spaceManager := BlSpaceManager new
]

{ #category : #testing }
BlUniverse >> isRunning [
	"Return true if I am running, false otherwise"
	<return: #Boolean>

	^ pulseLoop isNotNil and: [ pulseLoop isRunning ]
]

{ #category : #testing }
BlUniverse >> isUIProcess [
	^ self pulseLoop isRunningInTheSameProcess
]

{ #category : #testing }
BlUniverse >> isUIProcess: aProcess [
	^ aProcess = self pulseLoop loopProcess
]

{ #category : #'pulse managing' }
BlUniverse >> mainLoopPriority [
	^ self host mainLoopPriority
]

{ #category : #accessing }
BlUniverse >> preferableHost [
	^ preferableHost
]

{ #category : #accessing }
BlUniverse >> preferableHost: aBlHost [

	self
		assert: [ self isRunning not ]
		description: [ 'Universe must not be running!' ].

	self
		assert: [ preferableHost isNil or: [ preferableHost isRunning not ] ]
		description: [ 'Existing preferable host must not be running!' ].

	preferableHost := aBlHost
]

{ #category : #accessing }
BlUniverse >> pulseLoop [
	^ pulseLoop
]

{ #category : #accessing }
BlUniverse >> pulseLoop: anObject [
	pulseLoop := anObject
]

{ #category : #'pulse managing' }
BlUniverse >> pulseRequested [
	^ nextPulseRequested
]

{ #category : #'pulse managing' }
BlUniverse >> removePulseListener: anObject [
	pulseListeners remove: anObject.
	announcer unsubscribe: anObject.
	pulseListeners isEmpty
		ifTrue: [ self stop ]
]

{ #category : #'pulse managing' }
BlUniverse >> requestNextPulse [
	"Request next universe pulse You may want to request next pulse if you develop bloc extention
	and rely on BlPulseEvent to execute some action on universe/space pulse.
	By the contract next pulse can be only requested if universe is running.
	It is done to not create pulse loop when it is actually not needed (for example during testing)"

	self
		assert: [ self pulseLoop isNotNil ]
		description: [ 'Pulse loop must not be nil' ].
	
	self
		assert: [ self pulseLoop isRunning ]
		description: [ 'Pulse loop must be running in order to request a pulse' ].

	nextPulseRequested := true
]

{ #category : #'window managing' }
BlUniverse >> showSpaceWindow: aSpace [
	| shouldStartTheUniverse |
	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must not be nil' ].

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].

	shouldStartTheUniverse := self spaceManager hasSpaces not.

	"First of all we need to add space to the space manager"
	self spaceManager addSpace: aSpace.

	aSpace host
		ifNil: [ aSpace host: self host ].
	aSpace host isRunning
		ifFalse: [ aSpace host start ].

	"then create and show it in a host space"
	aSpace host createHostSpaceFor: aSpace.
	aSpace hostSpace show.

	self
		assert: [ aSpace hasHostSpace ]
		description: [ 'Space must have a host!' ].

	"We registered the first space, let's start the Universe"
	shouldStartTheUniverse
		ifTrue: [ self start ].

	"Note: we should send shown event after everything else is done, because
	theoretically, that only space could be closed as a reaction to the event"
	aSpace dispatchEvent: (BlSpaceShownEvent new space: self).
]

{ #category : #accessing }
BlUniverse >> spaceManager [
	^ spaceManager
]

{ #category : #accessing }
BlUniverse >> start [
	self pulseLoop start.
	self allSpacesDo: [ :aSpace | aSpace host isRunning ifFalse: [ aSpace host start ] ].
	self requestNextPulse
]

{ #category : #accessing }
BlUniverse >> stop [

	pulseListeners do: [ :each | each clear ].
		
	[ self pulseLoop stop ]
		"Otherwise host will not be stopped"
		ensure: [ self allSpacesDo: [ :aSpace | aSpace host isRunning ifTrue: [ aSpace host stop ] ] ]
]

{ #category : #'pulse managing' }
BlUniverse >> tryToRunDeferredActions [
	| nextInQueue |
	[ self pulseLoop timeIsUp not and: [ (nextInQueue := deferredActions nextOrNil) isNotNil ] ]
		whileTrue: [ nextInQueue value ].
	deferredActions isEmpty ifFalse: [ self requestNextPulse ]
]

{ #category : #'deferred actions' }
BlUniverse >> undefer: aValuable [
	"I remove previously deferred valuable from deferred actions queue if any
	and return true if aValuable existed, false otherwise.
	Note: Since I delete an action I do not request next pulse!"
	<return: #Boolean>
	| foundAny |
	
	foundAny := false.
	deferredActions flushAllSuchThat: [ :anAction | foundAny := foundAny or: [ anAction == aValuable ] ].
	^ foundAny
]
