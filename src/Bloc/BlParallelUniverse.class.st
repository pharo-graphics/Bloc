"
I represent a self-contained environment (a ""universe"") managing a collection of open spaces (`BlSpace`), a pipeline for deferred actions, and a synchronization mechanism for frame pulses. 

There can exist multiple universes running concurrently, each owned and run by a specific host (`BlHost`).

Key Responsibilities:
- **Space management**: Holds the collection of open spaces (`spaces`) that belong to this universe.
- **Action deferral**: Queues deferred block closures to be processed in a thread-safe manner before each frame pulse.
- **Pulsing lifecycle**: Implements `pulse` which runs layout, event, task, and drawing passes for all spaces in the universe, and executes deferred actions.
- **Synchronization**: Manages a list of registered pulse semaphores (`pulseSemaphores`). When a pulse completes, it signals these semaphores to wake up any threads waiting for state changes or animations (e.g. during `waitUntil:`).
"
Class {
	#name : #BlParallelUniverse,
	#superclass : #Object,
	#instVars : [
		'deferredActions',
		'spaces',
		'pulseSemaphores',
		'pulseSemaphoresMutex',
		'host',
		'isPulsing',
		'visibleSpacesOnShutdown',
		'spacesToOpen',
		'spacesToClose',
		'lifecycleMutex'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #'instance creation' }
BlParallelUniverse class >> host: aBlHost [

	^ self basicNew
		initializeWithHost: aBlHost;
		yourself
]

{ #category : #'api - spaces' }
BlParallelUniverse >> attachSpace: aSpace [

	(aSpace isOpened and: [ aSpace hostSpace isNotNil ]) ifTrue: [ ^ self ].

	spaces add: aSpace.

	[ aSpace hostSpaceOpen ] on: Exception do: [ :exception |
		spaces remove: aSpace ifAbsent: [ ].
		aSpace hostSpaceClose.
		exception pass ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> attachSpaceSynchronously: aSpace [

	self
		deprecated: 'Use #attachSpace: instead'
		transformWith: '`@receiver attachSpaceSynchronously: `@arg' -> '`@receiver attachSpace: `@arg'.

	^ self attachSpace: aSpace
]

{ #category : #'api - spaces' }
BlParallelUniverse >> closeSpace: aSpace [
	"Queue aSpace to be closed at the beginning of the next pulse."

	self lifecycleMutex critical: [
		(self spacesToOpen includes: aSpace) ifTrue: [
			self spacesToOpen remove: aSpace.
			^ self ].
		(spaces includes: aSpace) ifFalse: [ ^ self ].
		self spacesToClose add: aSpace ].

	host isRunning ifFalse: [ host start ].
	host requestPulse
]

{ #category : #'private - spaces' }
BlParallelUniverse >> closeSpaceNow: aSpace [

	"If space is not even opened we should do nothing"
	(spaces includes: aSpace) ifFalse: [ ^ self ].

	self detachSpace: aSpace.

	"Notify root element that it is no longer in scene graph"
	aSpace dispatchRemovedFromSceneGraph.

	"Send space closed event.
	Note: a new space may be opened as a reaction to the event. That is the reason to defer stopping of host and universe."
	aSpace dispatchEventWithTimestamp: BlSpaceClosedEvent new
]

{ #category : #'private - spaces' }
BlParallelUniverse >> closeSpaceSynchronously: aSpace [

	self
		deprecated: 'Use #closeSpace: instead'
		transformWith: '`@receiver closeSpaceSynchronously: `@arg' -> '`@receiver closeSpace: `@arg'.

	^ self closeSpace: aSpace
]

{ #category : #'api - spaces' }
BlParallelUniverse >> closeSpaces [

	self spaces copy do: [ :aSpace | aSpace close ]
]

{ #category : #'api - ui process' }
BlParallelUniverse >> defer: aValuable [
	"Enqueue a valuable from any process to be executed in the UI process at the beginning of the next pulse.
	It is useful to update the UI states."

	deferredActions nextPut: aValuable
]

{ #category : #'api - spaces' }
BlParallelUniverse >> detachSpace: aSpace [

	| aHost |
	"If space is not even opened we should do nothing"
	(spaces includes: aSpace) ifFalse: [ ^ self ].

	"We have to defer the check to the next frame, otherwise the UI loop may be terminated before frame finishes. 
	We have to store a reference to the original host because it may potentially change.
	Note: the actual termination of the host may happen after a host of the space is changed."
	aHost := aSpace host.

	"First, remove the space from space manager, to break any recursion."
	spaces remove: aSpace.

	"Then, tear down the host space"
	aSpace hostSpaceClose.

	"Dispatch an event indicating that the space is no longer attached to a universe"
	aSpace dispatchEventWithTimestamp: BlSpaceDetachedEvent new.

	aHost spaceDetached: aSpace
]

{ #category : #'private - spaces' }
BlParallelUniverse >> detachSpaceSynchronously: aSpace [

	self
		deprecated: 'Use #detachSpace: instead'
		transformWith: '`@receiver detachSpaceSynchronously: `@arg' -> '`@receiver detachSpace: `@arg'.

	^ self detachSpace: aSpace
]

{ #category : #'deferred message' }
BlParallelUniverse >> evaluateDeferredActions [

	| nextInQueue |
	[ (nextInQueue := deferredActions nextOrNil) isNotNil ]
		whileTrue: [ nextInQueue value ]
]

{ #category : #testing }
BlParallelUniverse >> hasDeferredActions [
	
	^ deferredActions isEmpty not
]

{ #category : #testing }
BlParallelUniverse >> hasPostponedActions [
	self
		deprecated: 'Use #hasDeferredActions instead'
		transformWith: '`@receiver hasPostponedActions' -> '`@receiver hasDeferredActions'.

	^ self hasDeferredActions
]

{ #category : #'api - pulse process' }
BlParallelUniverse >> hasPulseProcess [

	^ self pulseProcess isNotNil
]

{ #category : #'api - spaces' }
BlParallelUniverse >> hasSpace: aSpace [
	"Return true if a given space is registered, false otherwise"
	
	^ spaces includes: aSpace
]

{ #category : #'api - spaces' }
BlParallelUniverse >> hasSpaces [
	"Return true if there are registered spaces, false otherwise"

	^ spaces isNotEmpty
]

{ #category : #'api - pulse process' }
BlParallelUniverse >> hasUIProcess [

	self
		deprecated: 'Use #hasPulseProcess instead'
		transformWith: '`@receiver hasUIProcess' -> '`@receiver hasPulseProcess'.

	^ self hasPulseProcess
]

{ #category : #accessing }
BlParallelUniverse >> host [

	^ host
]

{ #category : #accessing }
BlParallelUniverse >> lifecycleMutex [

	^ lifecycleMutex ifNil: [ lifecycleMutex := Mutex new ]
]

{ #category : #accessing }
BlParallelUniverse >> spacesToClose [

	^ spacesToClose ifNil: [ spacesToClose := IdentitySet new ]
]

{ #category : #accessing }
BlParallelUniverse >> spacesToOpen [

	^ spacesToOpen ifNil: [ spacesToOpen := IdentitySet new ]
]

{ #category : #accessing }
BlParallelUniverse >> hostClass [

	self deprecated: 'Access the #host instance'.

	^ host class
]

{ #category : #accessing }
BlParallelUniverse >> hostClass: aHostClass [

	self deprecated: 'Set #host:'.

	host := aHostClass default
]

{ #category : #initialization }
BlParallelUniverse >> initialize [

	super initialize.

	spaces := IdentitySet new.
	spacesToOpen := IdentitySet new.
	spacesToClose := IdentitySet new.
	lifecycleMutex := Mutex new.
	host := BlHeadlessHost default.
	deferredActions := WaitfreeQueue new.
	pulseSemaphores := OrderedCollection new.
	pulseSemaphoresMutex := Mutex new
]

{ #category : #initialization }
BlParallelUniverse >> initializeWithHost: aHost [

	self initialize.

	host := aHost
]

{ #category : #testing }
BlParallelUniverse >> isPulsing [

	^ isPulsing ifNil: [ false ]
]

{ #category : #testing }
BlParallelUniverse >> isSettled [
	"Return true if there are no pending space openings, closings, or deferred actions"

	^ self lifecycleMutex critical: [
		self spacesToOpen isEmpty and: [
			self spacesToClose isEmpty and: [ deferredActions isEmpty ] ] ]
]

{ #category : #testing }
BlParallelUniverse >> isSpaceClosing: aSpace [

	^ self lifecycleMutex critical: [ self spacesToClose includes: aSpace ]
]

{ #category : #testing }
BlParallelUniverse >> isSpaceOpening: aSpace [

	^ self lifecycleMutex critical: [ self spacesToOpen includes: aSpace ]
]

{ #category : #'api - spaces' }
BlParallelUniverse >> openSpace: aSpace [
	"Queue aSpace to be opened at the beginning of the next pulse."

	(spaces includes: aSpace) ifTrue: [
		aSpace hostSpaceDo: [ :hs |
			aSpace becomeVisible.
			hs show ].
		^ self ].

	self lifecycleMutex critical: [
		self spacesToOpen add: aSpace ].

	host isRunning ifFalse: [ host start ].
	host requestPulse
]

{ #category : #'private - spaces' }
BlParallelUniverse >> openSpaceNow: aSpace [

	"If it has been already opened, just unhide it"
	(spaces includes: aSpace) ifTrue: [
		aSpace hasHostSpace ifTrue: [
			aSpace becomeVisible.
			^ aSpace hostSpace show ] ].

	self attachSpace: aSpace.

	"Note: we should send shown event after everything else is done, because
	theoretically, that only space could be closed as a reaction to the event"
	aSpace dispatchEventWithTimestamp: BlSpaceShownEvent new.

	"Notify root element that it is now visible to the user"
	aSpace becomeVisible.

	aSpace dispatchAddedToSceneGraph
]

{ #category : #'private - spaces' }
BlParallelUniverse >> openSpaceSynchronously: aSpace [

	self
		deprecated: 'Use #openSpace: instead'
		transformWith: '`@receiver openSpaceSynchronously: `@arg' -> '`@receiver openSpace: `@arg'.

	^ self openSpace: aSpace
]

{ #category : #'api - ui process' }
BlParallelUniverse >> postpone: aValuable [
	self
		deprecated: 'Use #defer: instead'
		transformWith: '`@receiver postpone: `@arg' -> '`@receiver defer: `@arg'.

	^ self defer: aValuable
]

{ #category : #printing }
BlParallelUniverse >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: host;
		nextPut: $)
]

{ #category : #pulse }
BlParallelUniverse >> pulse [
	"Execute a complete frame pulse for all managed spaces, processing pending lifecycle changes and deferred actions."

	| toClose toOpen semaphoresToSignal |
	isPulsing := true.
	[
		self lifecycleMutex critical: [
			toOpen := self spacesToOpen asArray.
			self spacesToOpen removeAll.
			toClose := self spacesToClose asArray.
			self spacesToClose removeAll ].

		[
			toOpen do: [ :eachSpace | self openSpaceNow: eachSpace ].
			toClose do: [ :eachSpace | self closeSpaceNow: eachSpace ].
			"Deferred actions must be run before spaces"
			self evaluateDeferredActions.
			spaces do: [ :eachSpace | eachSpace basicPulse ]
		] ifCurtailed: [
			self lifecycleMutex critical: [
				self spacesToClose addAll: (toClose reject: [ :s | (spaces includes: s) not ]).
				self spacesToOpen addAll: (toOpen reject: [ :s | spaces includes: s ]) ] ]
	] ensure: [
		isPulsing := false.
		(spaces isEmpty and: [ self isSettled ]) ifTrue: [
			host markStopped ].
		pulseSemaphoresMutex critical: [
			semaphoresToSignal := pulseSemaphores copy ].
		semaphoresToSignal do: [ :each | each signal ] ]
]

{ #category : #'api - pulse process' }
BlParallelUniverse >> pulseProcess [

	^ host pulseProcess
]

{ #category : #'api - pulse process' }
BlParallelUniverse >> pulseProcessDo: aBlock [

	self
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver pulseProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]

{ #category : #'private - spaces' }
BlParallelUniverse >> pulseSynchronously [

	self
		deprecated: 'Use #pulse instead'
		transformWith: '`@receiver pulseSynchronously' -> '`@receiver pulse'.

	^ self pulse
]

{ #category : #'api - pulse' }
BlParallelUniverse >> registerPulseSemaphore: aSemaphore [

	pulseSemaphoresMutex critical: [
		pulseSemaphores add: aSemaphore ]
]

{ #category : #'api - lifecycle' }
BlParallelUniverse >> snapshot: save andQuit: quit [

	self
		deprecated: 'Use Smalltalk snapshot:andQuit: deferred via #defer: instead'
		transformWith: '`@receiver snapshot: `@arg1 andQuit: `@arg2' -> '`@receiver defer: [ Smalltalk snapshot: `@arg1 andQuit: `@arg2 ]'.

	self defer: [ Smalltalk snapshot: save andQuit: quit ]
]

{ #category : #'api - spaces' }
BlParallelUniverse >> spaces [

	^ spaces
]

{ #category : #'private - lifecycle' }
BlParallelUniverse >> start [
	"A universe must not be running here.
	I am called outside of the UI loop (there is no UI loop yet)"

	| visibleSpaces |
	host start.
	visibleSpaces := visibleSpacesOnShutdown ifNil: [ IdentitySet new ].
	spaces do: [ :aSpace |
		aSpace hasHostSpace ifTrue: [
			aSpace hostSpace isValid
				ifTrue: [ aSpace onSessionChanged ]
				ifFalse: [
					aSpace hostSpaceClose.
					(visibleSpaces includes: aSpace) ifTrue: [
						aSpace hostSpaceOpen.
						aSpace onSessionChanged ] ] ] ].
	visibleSpacesOnShutdown := nil
]

{ #category : #'private - lifecycle' }
BlParallelUniverse >> startUniverse [

	self
		deprecated: 'Use #start instead'
		transformWith: '`@receiver startUniverse' -> '`@receiver start'.

	^ self start
]

{ #category : #'private - lifecycle' }
BlParallelUniverse >> stop [
	"A universe must be running here.
	I am called from the UI loop"
	
	visibleSpacesOnShutdown := (spaces select: [ :each | each isVisible ]) asIdentitySet.
	host stop
]

{ #category : #'private - lifecycle' }
BlParallelUniverse >> stopUniverse [

	self
		deprecated: 'Use #stop instead'
		transformWith: '`@receiver stopUniverse' -> '`@receiver stop'.

	^ self stop
]

{ #category : #'deferred message' }
BlParallelUniverse >> tryToRunDeferredActions [

	self
		deprecated: 'Use #evaluateDeferredActions instead'
		transformWith: '`@receiver tryToRunDeferredActions' -> '`@receiver evaluateDeferredActions'.

	^ self evaluateDeferredActions
]

{ #category : #'deferred message' }
BlParallelUniverse >> tryToRunPostponedActions [

	self
		deprecated: 'Use #evaluateDeferredActions instead'
		transformWith: '`@receiver tryToRunPostponedActions' -> '`@receiver evaluateDeferredActions'.

	^ self evaluateDeferredActions
]

{ #category : #'api - pulse process' }
BlParallelUniverse >> uiProcessDo: aBlock [

	self
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]

{ #category : #'api - pulse' }
BlParallelUniverse >> unregisterPulseSemaphore: aSemaphore [

	pulseSemaphoresMutex critical: [
		pulseSemaphores remove: aSemaphore ifAbsent: [] ]
]

{ #category : #'api - pulse' }
BlParallelUniverse >> waitUntil: aConditionValuable timeOutIf: aTimeoutValuable onCompletion: completionBlock onTimeout: timeoutBlock [

	| aSemaphore |
	self host denyPulseProcess.

	aConditionValuable value ifTrue: [ ^ completionBlock value ].

	aSemaphore := Semaphore new.
	self registerPulseSemaphore: aSemaphore.
	[
		[
			| midPulse |
			midPulse := self isPulsing.
			midPulse
				ifTrue: [ false ]
				ifFalse: [ aConditionValuable value ] ] whileFalse: [
				aTimeoutValuable value ifTrue: [ ^ timeoutBlock value ].
				aSemaphore waitTimeoutMilliseconds: 50 ] ] ensure: [
		self unregisterPulseSemaphore: aSemaphore ].

	^ completionBlock value
]
