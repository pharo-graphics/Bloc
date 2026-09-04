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
	#name : #BlUniverse,
	#superclass : #Object,
	#instVars : [
		'deferredActions',
		'spaces',
		'pulseSemaphores',
		'pulseSemaphoresMutex',
		'host',
		'isPulsing',
		'visibleSpacesOnShutdown'
	],
	#category : #'Bloc-Universe'
}

{ #category : #'instance creation' }
BlUniverse class >> host: aBlHost [

	^ self basicNew
		initializeWithHost: aBlHost;
		yourself
]

{ #category : #'api - spaces' }
BlUniverse >> attachSpace: aSpace [

	(aSpace isOpened and: [ aSpace hostSpace isNotNil ]) ifTrue: [ ^ self ].

	"First of all we need to add space to the space manager"
	(spaces includes: aSpace) ifFalse: [ spaces add: aSpace ].

	[
		aSpace hostSpaceOpen
	] on: Exception do: [ :ex |
		spaces remove: aSpace ifAbsent: [ ].
		aSpace hostSpaceClose.
		ex pass ]
]

{ #category : #'private - spaces' }
BlUniverse >> attachSpaceSynchronously: aSpace [

	self
		deprecated: 'Use #attachSpace: instead'
		transformWith: '`@receiver attachSpaceSynchronously: `@arg' -> '`@receiver attachSpace: `@arg'.

	^ self attachSpace: aSpace
]

{ #category : #'api - spaces' }
BlUniverse >> closeSpace: aSpace [

	"If space is not even opened we should do nothing"
	aSpace isOpened ifFalse: [ ^ self ].

	self detachSpace: aSpace.

	"Notify root element that it is no longer in scene graph"
	aSpace dispatchRemovedFromSceneGraph.
	
	"Send space closed event.
	Note: a new space may be opened as a reaction to the event. That is the reason to defer stopping of host and universe."
	aSpace dispatchEventWithTimestamp: BlSpaceClosedEvent new
]

{ #category : #'private - spaces' }
BlUniverse >> closeSpaceSynchronously: aSpace [

	self
		deprecated: 'Use #closeSpace: instead'
		transformWith: '`@receiver closeSpaceSynchronously: `@arg' -> '`@receiver closeSpace: `@arg'.

	^ self closeSpace: aSpace
]

{ #category : #'api - spaces' }
BlUniverse >> closeSpaces [

	self spaces copy do: [ :aSpace | aSpace close ]
]

{ #category : #'api - ui process' }
BlUniverse >> defer: aValuable [
	"Enqueue a valuable from any process to be executed in the UI process at the beginning of the next pulse.
	It is useful to update the UI states."

	deferredActions nextPut: aValuable
]

{ #category : #'api - lifecycle' }
BlUniverse >> deferSnapshot: save andQuit: quit [

	self defer: [ Smalltalk snapshot: save andQuit: quit ]
]

{ #category : #'api - spaces' }
BlUniverse >> detachSpace: aSpace [

	| aHost |
	"If space is not even opened we should do nothing"
	aSpace isOpened ifFalse: [ ^ self ].

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

	(spaces isEmpty and: [ aHost isRunning ]) ifTrue: [
		"We must defer host shutdown to let spaces perform actions as a result
		of a space closed event"
		self defer: [
			"As the last step, we may want to stop the host. It may terminate
			the UI loop process, so nothing should be executed after that"
			(spaces isEmpty and: [ aHost isRunning ]) ifTrue: [
				self stop ] ] ]
]

{ #category : #'private - spaces' }
BlUniverse >> detachSpaceSynchronously: aSpace [

	self
		deprecated: 'Use #detachSpace: instead'
		transformWith: '`@receiver detachSpaceSynchronously: `@arg' -> '`@receiver detachSpace: `@arg'.

	^ self detachSpace: aSpace
]

{ #category : #'deferred message' }
BlUniverse >> evaluateDeferred [

	| nextInQueue |
	[ (nextInQueue := deferredActions nextOrNil) isNotNil ]
		whileTrue: [ nextInQueue value ]
]

{ #category : #testing }
BlUniverse >> hasDeferredActions [
	
	^ deferredActions isEmpty not
]

{ #category : #testing }
BlUniverse >> hasPostponedActions [
	self
		deprecated: 'Use #hasDeferredActions instead'
		transformWith: '`@receiver hasPostponedActions' -> '`@receiver hasDeferredActions'.

	^ self hasDeferredActions
]

{ #category : #'api - pulse process' }
BlUniverse >> hasPulseProcess [

	^ self pulseProcess isNotNil
]

{ #category : #'api - spaces' }
BlUniverse >> hasSpace: aSpace [
	"Return true if a given space is registered, false otherwise"
	
	^ spaces includes: aSpace
]

{ #category : #'api - spaces' }
BlUniverse >> hasSpaces [
	"Return true if there are registered spaces, false otherwise"

	^ spaces isNotEmpty
]

{ #category : #'api - pulse process' }
BlUniverse >> hasUIProcess [

	self
		deprecated: 'Use #hasPulseProcess instead'
		transformWith: '`@receiver hasUIProcess' -> '`@receiver hasPulseProcess'.

	^ self hasPulseProcess
]

{ #category : #accessing }
BlUniverse >> host [

	^ host
]

{ #category : #accessing }
BlUniverse >> hostClass [

	self deprecated: 'Access the #host instance'.

	^ host class
]

{ #category : #accessing }
BlUniverse >> hostClass: aHostClass [

	self deprecated: 'Set #host:'.

	host := aHostClass default
]

{ #category : #initialization }
BlUniverse >> initialize [

	super initialize.

	spaces := OrderedCollection new.
	host := BlHeadlessHost default.
	deferredActions := WaitfreeQueue new.
	pulseSemaphores := OrderedCollection new.
	pulseSemaphoresMutex := Mutex new
]

{ #category : #initialization }
BlUniverse >> initializeWithHost: aHost [

	self initialize.

	host := aHost.
]

{ #category : #testing }
BlUniverse >> isPulsing [

	^ isPulsing ifNil: [ false ]
]

{ #category : #testing }
BlUniverse >> isSettled [
	"Return true if there are no deferred actions waiting to be executed"

	^ deferredActions isEmpty
]

{ #category : #'api - spaces' }
BlUniverse >> openSpace: aSpace [

	"If it has been already opened, just unhide it" 
	(aSpace isOpened and: [ aSpace hostSpace isNotNil ]) ifTrue: [ ^ aSpace hostSpace show ].

	self attachSpace: aSpace.

	"Note: we should send shown event after everything else is done, because
	theoretically, that only space could be closed as a reaction to the event"
	aSpace dispatchEventWithTimestamp: BlSpaceShownEvent new.

	"Notify root element that it is now visible to the user"
	aSpace becomeVisible.
	
	aSpace dispatchAddedToSceneGraph.

	BlSpaceOpenedSignal new
		space: aSpace;
		emit
]

{ #category : #'private - spaces' }
BlUniverse >> openSpaceSynchronously: aSpace [

	self
		deprecated: 'Use #openSpace: instead'
		transformWith: '`@receiver openSpaceSynchronously: `@arg' -> '`@receiver openSpace: `@arg'.

	^ self openSpace: aSpace
]

{ #category : #'api - ui process' }
BlUniverse >> postpone: aValuable [
	self
		deprecated: 'Use #defer: instead'
		transformWith: '`@receiver postpone: `@arg' -> '`@receiver defer: `@arg'.

	^ self defer: aValuable
]

{ #category : #printing }
BlUniverse >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: host;
		nextPut: $)
]

{ #category : #pulse }
BlUniverse >> pulse [

	| semaphoresToSignal |
	isPulsing := true.
	[
		[
			self evaluateDeferred.
			spaces do: [ :eachSpace | eachSpace basicPulse ]
		] 
			on: Exception 
			do: [ :e | 
				BlUniversePulseErrorSignal new
					error: e;
					emit.
				e pass ]
	] ensure: [
		isPulsing := false.
		pulseSemaphoresMutex critical: [
			semaphoresToSignal := pulseSemaphores copy ].
		semaphoresToSignal do: [ :each | each signal ] ]
]

{ #category : #'api - pulse process' }
BlUniverse >> pulseProcess [

	^ host pulseProcess
]

{ #category : #'api - pulse process' }
BlUniverse >> pulseProcessDo: aBlock [

	self
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver pulseProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]

{ #category : #'private - spaces' }
BlUniverse >> pulseSynchronously [

	self
		deprecated: 'Use #pulse instead'
		transformWith: '`@receiver pulseSynchronously' -> '`@receiver pulse'.

	^ self pulse
]

{ #category : #'api - pulse' }
BlUniverse >> registerPulseSemaphore: aSemaphore [

	pulseSemaphoresMutex critical: [
		pulseSemaphores add: aSemaphore ]
]

{ #category : #'api - lifecycle' }
BlUniverse >> snapshot: save andQuit: quit [

	self
		deprecated: 'Use #deferSnapshot:andQuit: instead'
		transformWith: '`@receiver snapshot: `@arg1 andQuit: `@arg2' -> '`@receiver deferSnapshot: `@arg1 andQuit: `@arg2'.

	self deferSnapshot: save andQuit: quit
]

{ #category : #'api - spaces' }
BlUniverse >> spaces [

	^ spaces
]

{ #category : #'private - lifecycle' }
BlUniverse >> start [
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
BlUniverse >> startUniverse [

	self
		deprecated: 'Use #start instead'
		transformWith: '`@receiver startUniverse' -> '`@receiver start'.

	^ self start
]

{ #category : #'private - lifecycle' }
BlUniverse >> stop [
	"A universe must be running here.
	I am called from the UI loop"
	
	visibleSpacesOnShutdown := (spaces select: [ :each | each isVisible ]) asIdentitySet.
	host stop
]

{ #category : #'private - lifecycle' }
BlUniverse >> stopUniverse [

	self
		deprecated: 'Use #stop instead'
		transformWith: '`@receiver stopUniverse' -> '`@receiver stop'.

	^ self stop
]

{ #category : #'deferred message' }
BlUniverse >> tryToRunDeferredActions [

	self
		deprecated: 'Use #evaluateDeferred instead'
		transformWith: '`@receiver tryToRunDeferredActions' -> '`@receiver evaluateDeferred'.

	^ self evaluateDeferred
]

{ #category : #'deferred message' }
BlUniverse >> tryToRunPostponedActions [
	self
		deprecated: 'Use #evaluateDeferred instead'
		transformWith: '`@receiver tryToRunPostponedActions' -> '`@receiver evaluateDeferred'.

	^ self evaluateDeferred
]

{ #category : #'api - pulse process' }
BlUniverse >> uiProcessDo: aBlock [

	self
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]

{ #category : #'api - pulse' }
BlUniverse >> unregisterPulseSemaphore: aSemaphore [

	pulseSemaphoresMutex critical: [
		pulseSemaphores remove: aSemaphore ifAbsent: [] ]
]

{ #category : #'api - pulse' }
BlUniverse >> waitUntil: aConditionValuable timeOutIf: aTimeoutValuable onCompletion: completionBlock onTimeout: timeoutBlock [

	| aSemaphore |
	self host denyPulseProcess.
	aSemaphore := Semaphore new.
	self registerPulseSemaphore: aSemaphore.
	[
		[
			| midPulse |
			midPulse := self isPulsing.
			midPulse
				ifTrue: [ false ]
				ifFalse: [ aConditionValuable value ]
		] whileFalse: [
			aTimeoutValuable value ifTrue: [ ^ timeoutBlock value ].
			self host isRunning
				ifTrue: [ aSemaphore waitTimeoutMilliseconds: 50 ]
				ifFalse: [
					self pulse.
					(Delay forMilliseconds: 1) wait ] ]
	] ensure: [
		self unregisterPulseSemaphore: aSemaphore ].
		
	^ completionBlock value
]
