"
I am a parallel Universe. There can exist multiple parallel universes

"
Class {
	#name : #BlParallelUniverse,
	#superclass : #Object,
	#instVars : [
		'deferredActions',
		'postponedActions',
		'hostClass',
		'spaces'
	],
	#classVars : [
		'Universes',
		'UniversesMutex'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverse class >> all [
	"Return a collection with all the registered instances"
	
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
			ifNone: [
				| aUniverse |
				aUniverse := self new hostClass: aHostClass; yourself.
				Universes := Universes copyWith: aUniverse.
				aUniverse ] ]
]

{ #category : #'class initialization' }
BlParallelUniverse class >> initialize [

	Universes := #().
	UniversesMutex := Mutex new.
	
	SessionManager default registerGuiClassNamed: self name
]

{ #category : #'system startup' }
BlParallelUniverse class >> shutDown [ 

	self all do: [ :anUniverse | anUniverse stopUniverse ]
]

{ #category : #'system startup' }
BlParallelUniverse class >> startUp [ 

	self all do: [ :anUniverse | anUniverse startUniverse ]
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

	aSpace isOpened ifTrue: [ ^ self ].

	"First of all we need to add space to the space manager"
	spaces add: aSpace.

	"then create and show it in a host space"
	aSpace host createHostSpaceFor: aSpace.

	aSpace hostSpace show
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
	aSpace dispatchEventWithTimestamp: BlSpaceClosedEvent new.


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

	"Then, destroy host space"
	aSpace hasHostSpace ifTrue: [ aSpace host destroyHostSpaceFor: aSpace ].

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

	spaces := OrderedCollection new.
	hostClass := BlHeadlessHost.
	deferredActions := WaitfreeQueue new.
	postponedActions := WaitfreeQueue new
]

{ #category : #'api - spaces' }
BlParallelUniverse >> openSpace: aSpace [
	"It should be possible to add a space from the other thread"

	self defer: [ self openSpaceSynchronously: aSpace ].

	aSpace host isRunning ifFalse: [ self startUniverse ]
]

{ #category : #'private - spaces' }
BlParallelUniverse >> openSpaceSynchronously: aSpace [

	aSpace isOpened ifTrue: [
		"If it has been already opened, just unhide it" 
		aSpace hostSpace show.
		^ self ].

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
		nextPutAll: hostClass asString;
		nextPut: $)
]

{ #category : #pulse }
BlParallelUniverse >> pulse [

	self pulseSynchronously
]

{ #category : #'private - spaces' }
BlParallelUniverse >> pulseSynchronously [
	"deferred actions must be run before spaces"

	[
		self tryToRunDeferredActions.
		spaces do: [ :eachSpace | eachSpace pulse ].
		self tryToRunPostponedActions
	] 
		on: Exception 
		do: [ :e | 
				(BlParallelUniverseErrorDuringPulseSignal new
					signaledError: e;
					yourself) emit.
				e pass ]
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

	hostClass start.
	spaces do: [ :aSpace | aSpace ensureWindowOpen ]
]

{ #category : #'private - lifecycle' }
BlParallelUniverse >> stopUniverse [
	"A universe must be running here.
	I am called from the UI loop"
	
	hostClass stop.
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

	hostClass uiProcessDo: aBlock
]
