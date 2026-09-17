"
I represent a self-contained in-image environment (a ""universe"") managing a collection of open spaces (`BlSpace`), a pipeline for deferred actions, and synchronization semaphores for frame pulses.

I am owned and coordinated by an in-image loop host (`BlPulseLoopHost`), which forwards `#pulse` to me from its pulse loop.

### Key Responsibilities
- **Space coordination**: Manages active `spaces` as well as queues for spaces being opened (`spacesToOpen`) or closed (`spacesToClose`) across pulse cycles under mutex protection.
- **Action deferral**: Queues block closures (`defer:`) from any thread and runs them safely at the beginning of the pulse cycle before frame phases execute.
- **Pulse execution**: Advances the frame lifecycle (`pulse`) across all open spaces, running tasks, layout, and rendering.
- **Synchronization**: Manages registered pulse semaphores (`pulseSemaphores`) signaled upon pulse completion, enabling thread-safe blocking waits (`waitUntil:timeOutIf:onCompletion:onTimeout:`).
- **Session management**: Coordinates space restoration (`start`, `stop`) across Pharo image snapshot and resume.

### Collaborators
- `BlPulseLoopHost` (`host`): The host that owns me and routes pulses to me.
- `BlSpace`: The visual spaces managed within this universe.
"
Class {
	#name : #BlParallelUniverse,
	#superclass : #Object,
	#instVars : [
		'deferredActions',
		'spaces',
		'pulseSemaphores',
		'mutex',
		'host',
		'visibleSpacesOnShutdown',
		'spacesToOpen',
		'spacesToClose',
		'pulsing'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'instance creation' }
BlParallelUniverse class >> host: aBlHost [

	^ self basicNew
		initializeWithHost: aBlHost;
		yourself
]

{ #category : #'api - spaces' }
BlParallelUniverse >> closeSpace: aSpace [
	"Queue aSpace to be closed at the beginning of the next pulse."

	mutex critical: [
		spacesToClose add: aSpace ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> closeSpaceNow: aSpace [

	spaces remove: aSpace ifAbsent: [ ^ self ].

	aSpace hostSpaceClose.
	aSpace dispatchRemovedFromSceneGraph.
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
		deprecated: 'Check host pulseProcess isNotNil instead'
		transformWith: '`@receiver hasUIProcess' -> '`@receiver host pulseProcess isNotNil'.

	^ host pulseProcess isNotNil
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
BlParallelUniverse >> initializeWithHost: aHost [

	super initialize.

	host := aHost.

	spaces := IdentitySet new.
	spacesToOpen := IdentitySet new.
	spacesToClose := IdentitySet new.
	mutex := Mutex new.
	deferredActions := WaitfreeQueue new.
	pulseSemaphores := OrderedCollection new.
	pulsing := false
]

{ #category : #testing }
BlParallelUniverse >> isPulsing [

	^ pulsing
]

{ #category : #testing }
BlParallelUniverse >> isSettled [
	"Return true if there are no pending space openings, closings, or deferred actions"

	^ mutex critical: [
		spacesToOpen isEmpty and: [
			spacesToClose isEmpty and: [ deferredActions isEmpty ] ] ]
]

{ #category : #testing }
BlParallelUniverse >> isSpaceClosing: aSpace [

	^ mutex critical: [ spacesToClose includes: aSpace ]
]

{ #category : #testing }
BlParallelUniverse >> isSpaceOpening: aSpace [

	^ mutex critical: [ spacesToOpen includes: aSpace ]
]

{ #category : #testing }
BlParallelUniverse >> isSpaceSettled: aSpace [
	"Return true if aSpace has no pending lifecycle actions and, if opened, all its frame phases are settled."

	^ mutex critical: [
		(spacesToOpen includes: aSpace) not and: [
			(spacesToClose includes: aSpace) not and: [
				(spaces includes: aSpace) not or: [
					aSpace areFramePhasesSettled ] ] ] ]
]

{ #category : #'api - spaces' }
BlParallelUniverse >> openSpace: aSpace [
	"Queue aSpace to be opened at the beginning of the next pulse."

	mutex critical: [
		spacesToOpen add: aSpace ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> openSpaceNow: aSpace [
	"If it has been already opened, just unhide it"

	(spaces includes: aSpace) ifTrue: [
		aSpace hasHostSpace ifTrue: [
			aSpace becomeVisible.
			^ aSpace hostSpace show ] ].

	spaces add: aSpace.
	[ aSpace hostSpaceOpen ] on: Exception do: [ :exception |
		spaces remove: aSpace ifAbsent: [ ].
		aSpace hostSpaceClose.
		exception pass ].

	aSpace becomeVisible.
	aSpace dispatchAddedToSceneGraph.
	aSpace dispatchEventWithTimestamp: BlSpaceShownEvent new
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
	pulsing := true.
	[
		mutex critical: [
			toOpen := spacesToOpen asArray.
			spacesToOpen removeAll.
			toClose := spacesToClose asArray.
			spacesToClose removeAll ].

		[
			toOpen do: [ :eachSpace | self openSpaceNow: eachSpace ].
			toClose do: [ :eachSpace | self closeSpaceNow: eachSpace ].
			"Deferred actions must be run before spaces"
			self evaluateDeferredActions.
			spaces do: [ :eachSpace | eachSpace basicPulse ]
		] ifCurtailed: [
			mutex critical: [
				spacesToClose addAll: (toClose reject: [ :s | (spaces includes: s) not ]).
				spacesToOpen addAll: (toOpen reject: [ :s | spaces includes: s ]) ] ]
	] ensure: [
		pulsing := false.
		(spaces isEmpty and: [ self isSettled ]) ifTrue: [ host requestStop ].
		mutex critical: [ semaphoresToSignal := pulseSemaphores copy ].
		semaphoresToSignal do: [ :each | each signal ] ]
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

	mutex critical: [
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
	Sent outside of the Pulse Loop (there is no Pulse Loop yet)."

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
	Sent from the UI loop."
	
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
		deprecated: 'Use host pulseProcess ifNotNil: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver host pulseProcess ifNotNil: `@arg'.

	^ host pulseProcess ifNotNil: aBlock
]

{ #category : #'api - pulse' }
BlParallelUniverse >> unregisterPulseSemaphore: aSemaphore [

	mutex critical: [
		pulseSemaphores remove: aSemaphore ifAbsent: [ ] ]
]

{ #category : #'api - pulse' }
BlParallelUniverse >> waitUntil: aConditionValuable timeOutIf: aTimeoutValuable onCompletion: completionBlock onTimeout: timeoutBlock [

	| aSemaphore |
	aConditionValuable value ifTrue: [ ^ completionBlock value ].

	aSemaphore := Semaphore new.
	self registerPulseSemaphore: aSemaphore.
	[
		[ self isPulsing not and: [ aConditionValuable value ] ] whileFalse: [
			aTimeoutValuable value ifTrue: [ ^ timeoutBlock value ].
			aSemaphore waitTimeoutMilliseconds: 50 ] ] ensure: [
		self unregisterPulseSemaphore: aSemaphore ].

	^ completionBlock value
]
