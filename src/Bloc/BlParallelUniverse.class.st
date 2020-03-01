"
I am a parallel Universe. There can exist multiple parallel universes
"
Class {
	#name : #BlParallelUniverse,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'deferredActions',
		'postponedActions',
		'eventDispatcher',
		'hostClass',
		'spaceManager',
		'pulsingStateMutex',
		'isPulsing'
	],
	#classVars : [
		'Universes',
		'UniversesMutex'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverse class >> all [
	"Return a collection of all parallel universes"
	
	^ Universes
]

{ #category : #'instance creation' }
BlParallelUniverse class >> existsForHost: aHostClass [
	^ UniversesMutex critical: [
		Universes
			detect: [ :eachUniverse | eachUniverse hostClass = aHostClass ]
			ifFound: [ true ]
			ifNone: [ false ] ]
]

{ #category : #'instance creation' }
BlParallelUniverse class >> forHost: aHostClass [
	^ UniversesMutex critical: [
		Universes
			detect: [ :eachUniverse | eachUniverse hostClass = aHostClass ]
			ifFound: #yourself
			ifNone: [
				| aUniverse |
				aUniverse := self new hostClass: aHostClass.
				Universes := Universes copyWith: aUniverse.
				aUniverse ] ]
]

{ #category : #'class initialization' }
BlParallelUniverse class >> initialize [
	Universes := #().
	UniversesMutex := Mutex new
]

{ #category : #'api - spaces' }
BlParallelUniverse >> closeSpace: aSpace [
	self defer: [ self closeSpaceSynchronously: aSpace ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> closeSpaceSynchronously: aSpace [
	| aHost |
	
	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must not be nil' ].

	"If space is not event opened we should do nothing"
	aSpace isOpened
		ifFalse: [ ^ self ].
		
	"we have to defer the check to the next frame, otherwise the UI loop may be terminated
	before frame finishes"

	"we have to store a reference to the original host because it may potentially change.
	for example assume the following:
	[[[
	aSpace close.
	aSpace host: BlHost pickHost.
	aSpace show
	]]]

	the actual termination of the host may happen after a host of the space is changed"
	aHost := aSpace host.
	
	"first remove space itself from space manager, to break any recursions"
	spaceManager removeSpace: aSpace.

	"then destroy host space"
	aSpace hasHostSpace
		ifTrue: [ aSpace host destroyHostSpaceFor: aSpace ].

	"Notify root element that it is no longer in scene graph"
	aSpace root dispatchRemovedFromSceneGraph.
	"Send space closed event.
	Note: a new space may be spawned as a reaction to the event, that is why
	we send it before stopping host and universe"
	aSpace dispatchEvent: (BlSpaceClosedEvent new space: aSpace).

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Host space must not have a host!' ].
	
	(spaceManager hasSpaces not and: [ aHost isRunning ])
		ifTrue: [
			"we must defer host shutdown to let spaces perform actions as a result
			of a space closed event"
			self defer: [
				"as the last step we may want to stop the host. It may terminate
				the current process, so we should do it at last"
				(spaceManager hasSpaces not and: [ aHost isRunning ])
					ifTrue: [ self stopUniverse ] ] ].
			
	"Raise an event indicating that all normal event for closing a space have been completed.
	This event is used by the debugger to stop the UI process. Users should not normally rely
	on this event, as there is no guarantee that the process will not be terminated."
	aSpace dispatchEvent: (BlSpaceDestroyedEvent new space: aSpace).
]

{ #category : #'api - spaces' }
BlParallelUniverse >> closeSpaces [
	self spaces copy do: [ :aSpace | self closeSpace: aSpace ]
]

{ #category : #initialization }
BlParallelUniverse >> defaultEventDispatcher [
	^ BlDirectEventDispatcher on: self
]

{ #category : #initialization }
BlParallelUniverse >> defaultEventListener [
	^ BlUniverseEventListener new
]

{ #category : #'api - ui process' }
BlParallelUniverse >> defer: aValuable [
	"#defer: can be used from any thread to execute a valuable in the GUI thread at the beginning of the next pulse.
	You can use it to update the GUI states from any other thread"

	(BlParallelUniverseDeferredActionAddedSignal new
		universe: self;
		action: aValuable) emit.

	deferredActions nextPut: aValuable
]

{ #category : #'event management accessing' }
BlParallelUniverse >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'api - spaces' }
BlParallelUniverse >> hasSpace: aSpace [
	"Return true if a given space is registered, false otherwise"
	<return: #Boolean>
	
	^ spaceManager hasSpace: aSpace
]

{ #category : #'api - spaces' }
BlParallelUniverse >> hasSpaces [
	"Return true if there are registered spaces, false otherwise"
	<return: #Boolean>

	^ spaceManager hasSpaces
]

{ #category : #'api - ui process' }
BlParallelUniverse >> hasUIProcess [
	self uiProcessDo: [ :aUIProcess | ^ true ].
	^ false
]

{ #category : #accessing }
BlParallelUniverse >> hostClass [
	^ hostClass
]

{ #category : #accessing }
BlParallelUniverse >> hostClass: aHostClass [
	hostClass := aHostClass
]

{ #category : #initialization }
BlParallelUniverse >> initialize [
	super initialize.

	spaceManager := BlSpaceManager new.
	hostClass := BlHeadlessHost.
	deferredActions := WaitfreeQueue new.
	postponedActions := WaitfreeQueue new.
	pulsingStateMutex := Mutex new.
	isPulsing := false.

	eventDispatcher := self defaultEventDispatcher.
	self addEventHandler: self defaultEventListener
]

{ #category : #accessing }
BlParallelUniverse >> isPulsing [
	<return: #Boolean>
	| areWePulsing |
	
	areWePulsing := false.
	pulsingStateMutex critical: [ areWePulsing := isPulsing ].
	^ areWePulsing
]

{ #category : #'private - spaces' }
BlParallelUniverse >> markAsNotPulsing [
	isPulsing := false
]

{ #category : #'api - spaces' }
BlParallelUniverse >> openSpace: aSpace [
	"It should be possible to add a space from the other thread"

	(BlParallelUniverseOpenSpaceRequestSignal new
		universe: self;
		space: aSpace;
		isRunning: aSpace host isRunning) emit.

	self defer: [ self openSpaceSynchronously: aSpace ].

	aSpace host isRunning
		ifFalse: [
			(BlParallelUniverseHostStartRequestSignal new
				universe: self;
				space: aSpace;
				host: aSpace host) emit.
			
			self startUniverse.
			
			(BlParallelUniverseHostStartedSignal new
				universe: self;
				space: aSpace;
				host: aSpace host;
				isRunning: aSpace host isRunning) emit ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> openSpaceSynchronously: aSpace [

	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must not be nil' ].

	aSpace isOpened
		ifTrue: [ ^ self ].

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host space!' ].

	self
		assert: [ aSpace host isNotNil ]
		description: [ 'Space must have a host' ].

	"First of all we need to add space to the space manager"
	spaceManager addSpace: aSpace.
	
	(BlParallelUniverseSpaceAddedSignal new
		universe: self;
		space: aSpace) emit.

	"then create and show it in a host space"
	aSpace host createHostSpaceFor: aSpace.
	
	(BlParallelUniverseHostSpaceCreatedSignal new
		universe: self;
		space: aSpace;
		hostSpace: aSpace hostSpace) emit.

	aSpace hostSpace show.
	
	(BlParallelUniverseHostSpaceShownSignal new
		universe: self;
		space: aSpace;
		hostSpace: aSpace hostSpace) emit.

	self
		assert: [ aSpace hasHostSpace ]
		description: [ 'Space must have a host!' ].
		
	"Note: we should send shown event after everything else is done, because
	theoretically, that only space could be closed as a reaction to the event"
	aSpace dispatchEvent: (BlSpaceShownEvent new space: self).

	"Notify root element that it is now visible to the user"
	aSpace root space: aSpace.
	
	(BlParallelUniverseSpaceRootAssignedSignal new
		universe: self;
		space: aSpace) emit.
	
	aSpace root dispatchAddedToSceneGraph.
	
	(BlParallelUniverseSpaceDispatchAddedToSceneSignal new
		universe: self;
		space: aSpace) emit
]

{ #category : #'api - ui process' }
BlParallelUniverse >> postpone: aValuable [
	"#postpone: can be used from any thread to execute a valuable in the GUI thread
	after the pulse is completed.
	I am different from #defer: in that #defer: actios are evaluated before the pulse of the universe"

	postponedActions nextPut: aValuable
]

{ #category : #pulse }
BlParallelUniverse >> pulse [
	self isPulsing
		ifTrue: [ ^ self ].

	pulsingStateMutex critical: [ isPulsing := true ].

	[
		self pulseSynchronously
	] ensure: [ self requestStopPulsation ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> pulseSynchronously [
	"deferred actions must be run before spaces"
	[
		self tryToRunDeferredActions.
		spaceManager do: [ :eachSpace | eachSpace pulse ]
	] ensure: [ self tryToRunPostponedActions ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> requestStopPulsation [
	pulsingStateMutex critical: [ 
		self uiProcessDo: [ :currentUIProcess | 
			"Only mark the universe as not pulsing in case the request comes from the current
			UI process or from a process that was not the Bloc UI process previously. This avoids 
			reseting the pulsing status when the debugger terminates a previously suspended UI process."
			(currentUIProcess == Processor activeProcess or: [ 
				Processor activeProcess name ~= 'Bloc UI Process' ]) ifTrue: [ 
					self markAsNotPulsing ] ] ]
]

{ #category : #'api - lifecycle' }
BlParallelUniverse >> snapshot: save andQuit: quit [
	self postpone: [ Smalltalk snapshot: save andQuit: quit ]
]

{ #category : #'api - spaces' }
BlParallelUniverse >> spaces [
	<return: #Collection of: #BlSpace>

	^ spaceManager spaces
]

{ #category : #'private - lifecycle' }
BlParallelUniverse >> startUniverse [
	"A universe must not be running here.
	I am called outside of the UI loop (there is no UI loop yet)"

	self markAsNotPulsing.
	self hostClass start
]

{ #category : #'private - lifecycle' }
BlParallelUniverse >> stopUniverse [
	"A universe must be running here.
	I am called from the UI loop"
	
	"to make sure that isPulsing is set back to false even if this Process is terminated"
	[ self hostClass stop ]
		ensure: [ self markAsNotPulsing ]
]

{ #category : #'deferred message' }
BlParallelUniverse >> tryToRunDeferredActions [
	| nextInQueue |

	(BlParallelUniverseTryToRunDeferredActionsSignal new universe: self) emit.

	[ (nextInQueue := deferredActions nextOrNil) isNotNil ]
		whileTrue: [
			(BlParallelUniverseRunDeferredActionSignal new
				universe: self;
				action: nextInQueue) emit.
			nextInQueue value ]
]

{ #category : #'deferred message' }
BlParallelUniverse >> tryToRunPostponedActions [
	| nextInQueue |
	
	[ (nextInQueue := postponedActions nextOrNil) isNotNil ]
		whileTrue: [ nextInQueue value ]
]

{ #category : #'api - ui process' }
BlParallelUniverse >> uiProcessDo: aBlock [
	self hostClass uiProcessDo: aBlock
]
