"
I am a rate-capped execution loop that periodically evaluates an action valuable.

I can run synchronously on the calling process (#run, #step) or manage a dedicated background process (#start, #stop, #basicStart).

### Pacing & Timing
- `periodUS`: Minimum duration in microseconds between consecutive evaluations (configured via #hertz: or #period:).
- If an evaluation takes longer than the period, I yield cooperatively to processes of the same priority.
- If spare time remains, I wait on `wakeUpSemaphore` with a timeout, allowing external callers to wake the loop immediately on demand (#wakeUp).

### Debugger Safety & Concurrency
- In background mode, unhandled exceptions during execution automatically spawn a successor process before opening the debugger, preventing the system UI from freezing.
- I track my designated process; if replaced during debugging or retired via #requestStop, the retired process exits cleanly.
"
Class {
	#name : #BlValueLoop,
	#superclass : #Object,
	#instVars : [
		'action',
		'periodUS',
		'lastUS',
		'durationUS',
		'wakeUpSemaphore',
		'loopProcess',
		'processPriority',
		'processName',
		'running'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : 'instance creation' }
BlValueLoop class >> action: aValuable [

	^ self basicNew
		initialize;
		action: aValuable;
		yourself
]

{ #category : 'instance creation' }
BlValueLoop class >> host: aHost [

	self
		deprecated: 'Use #action: instead'
		transformWith: '`@receiver host: `@arg' -> '`@receiver action: [ `@arg pulse ]'.

	^ (self action: [ aHost pulse ])
		processName: ('Bloc Value Loop ({1})' format: { aHost label });
		yourself
]

{ #category : 'accessing' }
BlValueLoop >> action [

	^ action
]

{ #category : 'accessing' }
BlValueLoop >> action: aValuable [

	action := aValuable
]

{ #category : 'lifecycle' }
BlValueLoop >> basicStart [
	"Start a new loop process unguardedly without checking if already running."

	self basicStart: self newLoopProcess
]

{ #category : 'lifecycle' }
BlValueLoop >> basicStart: aProcess [
	"Install and resume the given loop process unguardedly."

	loopProcess := aProcess.
	loopProcess resume
]

{ #category : 'debug' }
BlValueLoop >> forceStartNewUIProcess [
	self
		deprecated: 'Use #basicStart instead'
		transformWith: '`@receiver forceStartNewUIProcess' -> '`@receiver basicStart'.

	^ self basicStart
]

{ #category : 'debug' }
BlValueLoop >> forceStartOfUIProcess: aProcess [
	self
		deprecated: 'Use #basicStart: instead'
		transformWith: '`@receiver forceStartOfUIProcess: `@arg' -> '`@receiver basicStart: `@arg'.

	^ self basicStart: aProcess
]

{ #category : 'period' }
BlValueLoop >> hertz: aNumber [

	periodUS := (1000000.0 / aNumber) rounded
]

{ #category : 'initialization' }
BlValueLoop >> initialize [

	super initialize.
	self hertz: 60.
	action := [ "noop" ].
	wakeUpSemaphore := Semaphore new.
	processPriority := Processor userSchedulingPriority.
	processName := 'Bloc Value Loop'.
	running := false
]

{ #category : 'testing' }
BlValueLoop >> isLoopProcessActive [

	^ Processor activeProcess == loopProcess
]

{ #category : 'testing' }
BlValueLoop >> isPulseProcessActive [

	^ self isLoopProcessActive
]

{ #category : 'testing' }
BlValueLoop >> isRunning [

	^ running and: [ loopProcess isNotNil and: [ loopProcess isTerminated not ] ]
]

{ #category : 'loop process' }
BlValueLoop >> loop [

	[ self loopIteration ] whileTrue
]

{ #category : 'loop process' }
BlValueLoop >> loopIteration [

	self isRunning ifFalse: [ ^ false ].

	[
		self step.
		self isRunning ifFalse: [ ^ false ]
	] on: Exception do: [ :e |
		self basicStart.
		e pass ].

	^ self isLoopProcessActive
]

{ #category : 'accessing' }
BlValueLoop >> loopProcess [

	^ loopProcess
]

{ #category : 'loop process' }
BlValueLoop >> newLoopProcess [

	^ [ self loop ] newProcess
		priority: self processPriority;
		name: self processName;
		yourself
]

{ #category : 'period' }
BlValueLoop >> period [

	^ periodUS microSeconds
]

{ #category : 'period' }
BlValueLoop >> period: aDuration [

	periodUS := aDuration asMicroseconds max: 1
]

{ #category : 'period' }
BlValueLoop >> periodAsSeconds [

	^ periodUS / 1000000.0
]

{ #category : 'loop process' }
BlValueLoop >> processName [

	^ processName
]

{ #category : 'loop process' }
BlValueLoop >> processName: aString [

	processName := aString
]

{ #category : 'loop process' }
BlValueLoop >> processPriority [

	^ processPriority ifNil: [ Processor userSchedulingPriority ]
]

{ #category : 'loop process' }
BlValueLoop >> processPriority: aNumber [

	processPriority := aNumber
]

{ #category : 'period' }
BlValueLoop >> pulsePeriod [

	^ self period
]

{ #category : 'period' }
BlValueLoop >> pulsePeriod: aDuration [

	self period: aDuration
]

{ #category : 'accessing' }
BlValueLoop >> pulseProcess [

	^ loopProcess
]

{ #category : 'lifecycle' }
BlValueLoop >> requestStop [
	"Request the loop process to stop gracefully at the end of the current iteration."

	running := false.
	loopProcess := nil
]

{ #category : 'running' }
BlValueLoop >> run [
	"Synchronous execution on the current process"

	running := true.
	[ self step ] doWhileTrue: [ running ]
]

{ #category : 'lifecycle' }
BlValueLoop >> start [

	self isRunning ifTrue: [ ^ self ].

	running := true.
	self basicStart
]

{ #category : 'loop process' }
BlValueLoop >> step [

	| startUS waitUS waitMS |
	wakeUpSemaphore consumeAllSignals.
	startUS := Time microsecondClockValue.

	action value.

	lastUS := Time microsecondClockValue.
	durationUS := lastUS - startUS.
	waitUS := periodUS - durationUS.

	waitUS <= 0 ifTrue: [ ^ Processor yield ].

	waitMS := (waitUS + 500) // 1000.
	waitMS > 0 ifTrue: [
		wakeUpSemaphore waitTimeoutMilliseconds: waitMS ]
]

{ #category : 'lifecycle' }
BlValueLoop >> stop [
	"Stop the loop process. Can be safely sent from any process, including the loop process itself."

	| currentProcess isCurrentActive |
	self isRunning ifFalse: [ ^ self ].

	running := false.
	isCurrentActive := self isLoopProcessActive.
	currentProcess := loopProcess.
	loopProcess := nil.

	isCurrentActive ifFalse: [
		currentProcess ifNotNil: [ currentProcess terminate ] ]
]

{ #category : 'accessing' }
BlValueLoop >> target: anObject selector: aSymbol [

	action := MessageSend receiver: anObject selector: aSymbol
]

{ #category : 'lifecycle' }
BlValueLoop >> wakeUp [
	"Wake up the loop process immediately if sleeping between frames, or start it if not running."

	self isRunning ifFalse: [ ^ self start ].
	wakeUpSemaphore signal
]
