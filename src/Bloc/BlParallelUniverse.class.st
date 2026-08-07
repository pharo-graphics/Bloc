"
I represent a self-contained environment (a ""universe"") managing a collection of open spaces (`BlSpace`), a pipeline for deferred/postponed actions, and a synchronization mechanism for frame pulses. 

There can exist multiple parallel universes running concurrently, each owned and run by a specific host (`BlHost`).

Key Responsibilities:
- **Space management**: Holds the collection of open spaces (`spaces`) that belong to this universe.
- **Action deferral**: Queues deferred and postponed block closures to be processed in a thread-safe manner at specific lifecycle stages of a pulse.
- **Pulsing lifecycle**: Implements `pulseSynchronously` which runs layout, event, task, and drawing passes for all spaces in the universe, and executes deferred/postponed actions.
- **Synchronization**: Manages a list of registered pulse semaphores (`pulseSemaphores`). When a pulse completes, it signals these semaphores to wake up any threads waiting for state changes or animations (e.g. during `waitUntil:`).
"
Class {
	#name : #BlParallelUniverse,
	#superclass : #Object,
	#instVars : [
		'deferredActions',
		'postponedActions',
		'spaces',
		'pulseSemaphores',
		'pulseSemaphoresMutex',
		'host',
		'isPulsing'
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
	"Attach a given space to the universe. It is assumed that the space was previously detached from another Universe.
	Is useful for changing space host."

	self defer: [ self attachSpaceSynchronously: aSpace ].

	aSpace host isRunning ifFalse: [ self startUniverse ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> attachSpaceSynchronously: aSpace [

	(aSpace isOpened and: [ aSpace hostSpace isNotNil ]) ifTrue: [ ^ self ].

	"First of all we need to add space to the space manager"
	(spaces includes: aSpace) ifFalse: [ spaces add: aSpace ].

	[
		aSpace setUpHostSpace.
		aSpace hostSpace open
	] on: Exception do: [ :ex |
		spaces remove: aSpace ifAbsent: [ ].
		aSpace tearDownHostSpace.
		ex pass ]
]

{ #category : #'api - spaces' }
BlParallelUniverse >> closeSpace: aSpace [

	aSpace isOpened ifFalse: [ ^ self ].
	self defer: [ self closeSpaceSynchronously: aSpace ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> closeSpaceSynchronously: aSpace [

	"If space is not even opened we should do nothing"
	aSpace isOpened ifFalse: [ ^ self ].

	self detachSpaceSynchronously: aSpace.

	"Notify root element that it is no longer in scene graph"
	aSpace dispatchRemovedFromSceneGraph.
	
	"Send space closed event.
	Note: a new space may be opened as a reaction to the event. That is the reason to defer stopping of host and universe."
	aSpace dispatchEventWithTimestamp: BlSpaceClosedEvent new
]

{ #category : #'api - spaces' }
BlParallelUniverse >> closeSpaces [

	self spaces copy do: [ :aSpace | self closeSpace: aSpace ]
]

{ #category : #'api - ui process' }
BlParallelUniverse >> defer: aValuable [
	"Enqueue a valuable from any process to be executed in the UI process at the beginning of the next pulse.
	It is useful to update the UI states."

	deferredActions nextPut: aValuable
]

{ #category : #'api - spaces' }
BlParallelUniverse >> detachSpace: aSpace [
	"Detach an opened space from this universe without actually closing the space.
	Space detaching is useful for switching hosts and transferring spaces between universes."

	aSpace isOpened ifFalse: [ ^ self ].
	self defer: [ self detachSpaceSynchronously: aSpace ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> detachSpaceSynchronously: aSpace [

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
	aSpace tearDownHostSpace.

	"Dispatch an event indicating that the space is no longer attached to a universe"
	aSpace dispatchEventWithTimestamp: BlSpaceDetachedEvent new.

	(spaces isEmpty and: [ aHost isRunning ]) ifTrue: [
		"We must defer host shutdown to let spaces perform actions as a result
		of a space closed event"
		self defer: [
			"As the last step, we may want to stop the host. It may terminate
			the current process, so we should do it at the end."
			(spaces isEmpty and: [ aHost isRunning ]) ifTrue: [
				self stopUniverse ] ] ]
]

{ #category : #testing }
BlParallelUniverse >> hasDeferredActions [
	
	^ deferredActions isEmpty not
]

{ #category : #testing }
BlParallelUniverse >> hasPostponedActions [
	
	^ postponedActions isEmpty not
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

{ #category : #'api - ui process' }
BlParallelUniverse >> hasUIProcess [

	self uiProcessDo: [ :aUIProcess | ^ true ].
	^ false
]

{ #category : #accessing }
BlParallelUniverse >> host [

	^ host
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

	spaces := OrderedCollection new.
	host := BlHeadlessHost default.
	deferredActions := WaitfreeQueue new.
	postponedActions := WaitfreeQueue new.
	pulseSemaphores := OrderedCollection new.
	pulseSemaphoresMutex := Mutex new.
]

{ #category : #initialization }
BlParallelUniverse >> initializeWithHost: aHost [

	self initialize.

	host := aHost.
]

{ #category : #'api - spaces' }
BlParallelUniverse >> openSpace: aSpace [
	"It should be possible to add a space from the other thread"

	self defer: [ self openSpaceSynchronously: aSpace ].

	aSpace host isRunning ifFalse: [ self startUniverse ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> openSpaceSynchronously: aSpace [

	"If it has been already opened, just unhide it" 
	(aSpace isOpened and: [ aSpace hostSpace isNotNil ]) ifTrue: [ ^ aSpace hostSpace show ].

	self attachSpaceSynchronously: aSpace.

	"Note: we should send shown event after everything else is done, because
	theoretically, that only space could be closed as a reaction to the event"
	aSpace dispatchEventWithTimestamp: BlSpaceShownEvent new.

	"Notify root element that it is now visible to the user"
	aSpace becomeVisible.
	
	aSpace dispatchAddedToSceneGraph
]

{ #category : #'api - ui process' }
BlParallelUniverse >> postpone: aValuable [
	"#postpone: can be used from any thread to execute a valuable in the GUI thread
	after the pulse is completed.
	I am different from #defer: in that #defer: actios are evaluated before the pulse of the universe"
	
	postponedActions nextPut: aValuable
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

	self pulseSynchronously
]

{ #category : #'api - pulse' }
BlParallelUniverse >> pulseSemaphores [

	^ pulseSemaphores ifNil: [ pulseSemaphores := OrderedCollection new ]
]

{ #category : #'api - pulse' }
BlParallelUniverse >> pulseSemaphoresMutex [

	^ pulseSemaphoresMutex ifNil: [ pulseSemaphoresMutex := Mutex new ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> pulseSynchronously [
	"deferred actions must be run before spaces"

	| semaphoresToSignal |
	isPulsing := true.
	[
		[
			self tryToRunDeferredActions.
			spaces do: [ :eachSpace | eachSpace pulse ].
			self tryToRunPostponedActions.
			
			self pulseSemaphoresMutex critical: [ semaphoresToSignal := self pulseSemaphores copy ].
			semaphoresToSignal do: [ :each | each signal ]
		] 
			on: Exception 
			do: [ :e | 
					[
						Stdio stderr
							nextPutAll: 'Error during pulse: ';
							nextPutAll: e description;
							lf.
						e signalerContext stack printOn: Stdio stderr.
						Stdio stderr lf ] on: Error do: [ ].
					(BlParallelUniverseErrorDuringPulseSignal new
						signaledError: e;
						yourself) emit.
					e pass ]
	] ensure: [ isPulsing := false ]
]

{ #category : #'api - pulse' }
BlParallelUniverse >> registerPulseSemaphore: aSemaphore [

	self pulseSemaphoresMutex critical: [ self pulseSemaphores add: aSemaphore ]
]

{ #category : #'api - lifecycle' }
BlParallelUniverse >> snapshot: save andQuit: quit [

	self postpone: [ Smalltalk snapshot: save andQuit: quit ]
]

{ #category : #'api - spaces' }
BlParallelUniverse >> spaces [

	^ spaces
]

{ #category : #'private - lifecycle' }
BlParallelUniverse >> startUniverse [
	"A universe must not be running here.
	I am called outside of the UI loop (there is no UI loop yet)"

	host start.
	spaces do: [ :aSpace | aSpace ensureWindowOpen ]
]

{ #category : #'private - lifecycle' }
BlParallelUniverse >> stopUniverse [
	"A universe must be running here.
	I am called from the UI loop"
	
	host stop.
	spaces do: [ :anSpace | anSpace rememberVisibleStatus ]
]

{ #category : #'deferred message' }
BlParallelUniverse >> tryToRunDeferredActions [

	| nextInQueue |

	[ (nextInQueue := deferredActions nextOrNil) isNotNil ]
		whileTrue: [ nextInQueue value ]
]

{ #category : #'deferred message' }
BlParallelUniverse >> tryToRunPostponedActions [

	| nextInQueue |
	
	[ (nextInQueue := postponedActions nextOrNil) isNotNil ]
		whileTrue: [ nextInQueue value ]
]

{ #category : #'api - ui process' }
BlParallelUniverse >> uiProcessDo: aBlock [

	host uiProcessDo: aBlock
]

{ #category : #'api - pulse' }
BlParallelUniverse >> unregisterPulseSemaphore: aSemaphore [

	self pulseSemaphoresMutex critical: [ self pulseSemaphores remove: aSemaphore ifAbsent: [  ] ]
]

{ #category : #testing }
BlParallelUniverse >> isPulsing [

	^ isPulsing ifNil: [ false ]
]

{ #category : #'api - pulse' }
BlParallelUniverse >> waitUntil: aBlock timeout: aTimeoutBlock onCompletion: completionBlock onTimeout: timeoutBlock [

	| aSemaphore |
	aSemaphore := Semaphore new.
	self registerPulseSemaphore: aSemaphore.
	[
		[
			| midPulse |
			midPulse := self host isUIProcess not and: [ self isPulsing ].
			midPulse
				ifTrue: [ false ]
				ifFalse: [ aBlock value ]
		] whileFalse: [
			aTimeoutBlock value ifTrue: [ ^ timeoutBlock value ].
			self host isRunning
				ifTrue: [ aSemaphore waitTimeoutMilliseconds: 50 ]
				ifFalse: [
					self pulse.
					(Delay forMilliseconds: 1) wait ] ]
	] ensure: [
		self unregisterPulseSemaphore: aSemaphore ].
		
	^ completionBlock value
]
