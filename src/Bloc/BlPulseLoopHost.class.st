"
I am an abstract host for in-image, loop-driven Bloc environments.

I combine a background pulse loop thread (`BlHostPulseLoop`) with a local space coordinator (`BlParallelUniverse`) to execute and render spaces within the current Pharo image.

### How I Work
- **Pulse loop**: My `pulseLoop` runs a dedicated high-priority process that periodically sends `#pulse` to me according to `pulsePeriod`.
- **Universe pulsing**: When I receive `#pulse`, I forward it to my `universe`. The universe executes deferred tasks (`defer:`) and triggers frame phases (events, layout, redraw) across all registered spaces.
- **On-demand pulsing**: Senders can call `requestPulse` from any thread (e.g. when enqueueing a task or invalidating geometry) to wake up the loop immediately.

### Collaborators
- `BlParallelUniverse` (`universe`): Manages the collection of open, opening, and closing spaces (`BlSpace`), the deferred action queue, and pulse synchronization semaphores.
- `BlHostPulseLoop` (`pulseLoop`): The background looping process driving periodic frame pulses and cooperative idling.
- `BlSpace`: The spaces opened and managed on this host.
- Subclasses (`BlOSSDL3Host`, `BlOSWindowSDL2Host`, `BlMorphicWindowHost`, `BlHeadlessHost`): Concrete drivers implementing native window creation (`newHostSpaceFor:`) and renderer instantiation (`newHostRenderer`).
"
Class {
	#name : #BlPulseLoopHost,
	#superclass : #BlHost,
	#instVars : [
		'pulseLoop',
		'universe'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'api - spaces' }
BlPulseLoopHost >> closeSpace: aSpace [
	"Close aSpace managed by this host."

	self universe closeSpace: aSpace.
	self requestPulse
]

{ #category : #'api - spaces' }
BlPulseLoopHost >> closeSpaces [
	"Close all spaces managed by this host."

	self hasUniverse ifTrue: [
		self universe closeSpaces ]
]

{ #category : #'api - spaces' }
BlPulseLoopHost >> defer: aValuable [
	"Enqueue a valuable from any process to be executed in the host UI process at the beginning of the next pulse cycle."

	self universe defer: aValuable.
	self requestPulse
]

{ #category : #testing }
BlPulseLoopHost >> hasUniverse [

	^ universe isNotNil
]

{ #category : #initialization }
BlPulseLoopHost >> initialize [

	super initialize.
	pulseLoop := BlHostPulseLoop host: self
]

{ #category : #'host - testing' }
BlPulseLoopHost >> isPulseProcessActive [
	"Return true if the active process is the pulse loop process of this host"

	^ pulseLoop isNotNil and: [ pulseLoop isPulseProcessActive ]
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> isRunning [

	^ pulseLoop isRunning
]

{ #category : #testing }
BlPulseLoopHost >> isSettled [
	"Return true if there are no deferred actions waiting to be executed on this host."

	^ self hasUniverse not or: [ self universe isSettled ]
]

{ #category : #testing }
BlPulseLoopHost >> isSpaceClosing: aSpace [
	"Return true if a given space is currently queued to be closed on this host, false otherwise."

	^ self hasUniverse and: [ self universe isSpaceClosing: aSpace ]
]

{ #category : #testing }
BlPulseLoopHost >> isSpaceOpening: aSpace [
	"Return true if a space is currently queued to be opened on this host, false otherwise."

	^ self hasUniverse and: [ self universe isSpaceOpening: aSpace ]
]

{ #category : #testing }
BlPulseLoopHost >> isSpaceSettled: aSpace [
	"Return true if there are no pending lifecycle actions for aSpace and, if opened, all its frame phases are settled."

	^ self hasUniverse not or: [ self universe isSpaceSettled: aSpace ]
]

{ #category : #'api - spaces' }
BlPulseLoopHost >> openSpace: aSpace [
	"Open aSpace on this host."

	self universe openSpace: aSpace.
	self requestPulse
]

{ #category : #'api - pulse' }
BlPulseLoopHost >> pulse [
	"Execute a single pulse cycle across all spaces managed by this host."

	self hasUniverse ifTrue: [ self universe pulse ]
]

{ #category : #accessing }
BlPulseLoopHost >> pulseLoop [

	^ pulseLoop
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> pulsePeriod [

	^ pulseLoop pulsePeriod
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> pulsePeriod: aDuration [

	pulseLoop pulsePeriod: aDuration
]

{ #category : #'api - pulse process' }
BlPulseLoopHost >> pulseProcess [
	"Return the pulse loop Process if running, or nil."

	^ pulseLoop pulseProcess
]

{ #category : #enumerating }
BlPulseLoopHost >> pulseProcessDo: aBlock [
	"Evaluate aBlock with the running pulse Process of this host if any"

	self
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver pulseProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> requestPulse [
	"Request an immediate pulse cycle from the pulse loop."

	pulseLoop wakeUp
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> requestStop [
	"Request the pulse loop to stop without terminating the active process."

	pulseLoop requestStop
]

{ #category : #'system startup' }
BlPulseLoopHost >> shutDown: isQuitting [
	"Handle system shutdown / session suspend."

	self hasUniverse ifTrue: [ self universe stop ]
]

{ #category : #'host space - accessing' }
BlPulseLoopHost >> spaces [
	"Answer the collection of spaces managed by this host."

	^ self hasUniverse
		ifTrue: [ self universe spaces ]
		ifFalse: [ #() ]
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> start [

	pulseLoop start
]

{ #category : #'system startup' }
BlPulseLoopHost >> startUp: isResuming [
	"Handle system startup / session resume."

	self hasUniverse ifTrue: [ self universe start ]
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> stop [

	pulseLoop stop
]

{ #category : #enumerating }
BlPulseLoopHost >> uiProcessDo: aBlock [

	self
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]

{ #category : #accessing }
BlPulseLoopHost >> universe [

	^ universe ifNil: [ universe := BlParallelUniverse host: self ]
]

{ #category : #'host - testing' }
BlPulseLoopHost >> waitUntil: aConditionValuable timeOutIf: aTimeoutValuable onCompletion: completionBlock onTimeout: timeoutBlock [
	"Evaluate aConditionValuable repeatedly until it answers true. If aTimeoutValuable answers true first, evaluate timeoutBlock. Otherwise, evaluate completionBlock."

	self denyPulseProcess.

	^ self universe
		  waitUntil: aConditionValuable
		  timeOutIf: aTimeoutValuable
		  onCompletion: completionBlock
		  onTimeout: timeoutBlock
]
