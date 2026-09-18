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
	#name : #BlHostPulseLoop,
	#superclass : #Object,
	#instVars : [
		'periodUS',
		'lastUS',
		'durationUS',
		'wakeUpSemaphore',
		'loopProcess',
		'processPriority',
		'processName',
		'running',
		'valuable'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #lifecycle }
BlHostPulseLoop >> basicStart [
	"Start a new loop process unguardedly without checking if already running."

	self basicStart: self newLoopProcess
]

{ #category : #lifecycle }
BlHostPulseLoop >> basicStart: aProcess [
	"Install and resume the given loop process unguardedly."

	loopProcess := aProcess.
	loopProcess resume
]

{ #category : #debug }
BlHostPulseLoop >> forceStartNewUIProcess [

	self
		deprecated: 'Use #basicStart instead'
		transformWith: '`@receiver forceStartNewUIProcess' -> '`@receiver basicStart'.

	^ self basicStart
]

{ #category : #debug }
BlHostPulseLoop >> forceStartOfUIProcess: aProcess [

	self
		deprecated: 'Use #basicStart: instead'
		transformWith: '`@receiver forceStartOfUIProcess: `@arg' -> '`@receiver basicStart: `@arg'.

	^ self basicStart: aProcess
]

{ #category : #period }
BlHostPulseLoop >> hertz: aNumber [

	periodUS := (1000000.0 / aNumber) rounded
]

{ #category : #initialization }
BlHostPulseLoop >> initialize [

	super initialize.
	self hertz: 60.
	valuable := [ "noop" ].
	wakeUpSemaphore := Semaphore new.
	processPriority := Processor userSchedulingPriority.
	processName := 'Bloc Value Loop'.
	running := false
]

{ #category : #testing }
BlHostPulseLoop >> isLoopProcessActive [

	^ Processor activeProcess == loopProcess
]

{ #category : #testing }
BlHostPulseLoop >> isPulseProcessActive [

	^ self isLoopProcessActive
]

{ #category : #testing }
BlHostPulseLoop >> isRunning [

	^ running and: [ loopProcess isNotNil and: [ loopProcess isTerminated not ] ]
]

{ #category : #'loop process' }
BlHostPulseLoop >> loop [

	[ self loopIteration ] whileTrue
]

{ #category : #'loop process' }
BlHostPulseLoop >> loopIteration [

	self isRunning ifFalse: [ ^ false ].

	[
		self step.
		self isRunning ifFalse: [ ^ false ]
	] on: Exception do: [ :e |
		self basicStart.
		e pass ].

	^ self isLoopProcessActive
]

{ #category : #accessing }
BlHostPulseLoop >> loopProcess [

	^ loopProcess
]

{ #category : #'loop process' }
BlHostPulseLoop >> newLoopProcess [

	^ [ self loop ] newProcess
		priority: self processPriority;
		name: self processName;
		yourself
]

{ #category : #period }
BlHostPulseLoop >> period [

	^ periodUS microSeconds
]

{ #category : #period }
BlHostPulseLoop >> period: aDuration [

	periodUS := aDuration asMicroseconds max: 1
]

{ #category : #period }
BlHostPulseLoop >> periodAsSeconds [

	^ periodUS / 1000000.0
]

{ #category : #'loop process' }
BlHostPulseLoop >> processName [

	^ processName
]

{ #category : #'loop process' }
BlHostPulseLoop >> processName: aString [

	processName := aString
]

{ #category : #'loop process' }
BlHostPulseLoop >> processPriority [

	^ processPriority ifNil: [ Processor userSchedulingPriority ]
]

{ #category : #'loop process' }
BlHostPulseLoop >> processPriority: aNumber [
	"Change the Process priority (takes effect on next #start)"

	processPriority := aNumber
]

{ #category : #period }
BlHostPulseLoop >> pulsePeriod [

	^ self period
]

{ #category : #period }
BlHostPulseLoop >> pulsePeriod: aDuration [

	self period: aDuration
]

{ #category : #accessing }
BlHostPulseLoop >> pulseProcess [

	^ loopProcess
]

{ #category : #lifecycle }
BlHostPulseLoop >> requestStop [
	"Request the loop process to stop gracefully at the end of the current iteration."

	running := false.
	loopProcess := nil
]

{ #category : #running }
BlHostPulseLoop >> run [
	"Synchronous execution on the current process"

	running := true.
	[ self step ] doWhileTrue: [ running ]
]

{ #category : #lifecycle }
BlHostPulseLoop >> start [

	self isRunning ifTrue: [ ^ self ].

	running := true.
	self basicStart
]

{ #category : #'loop process' }
BlHostPulseLoop >> step [

	| startUS waitUS waitMS |
	wakeUpSemaphore consumeAllSignals.
	startUS := Time microsecondClockValue.

	valuable value.

	lastUS := Time microsecondClockValue.
	durationUS := lastUS - startUS.
	waitUS := periodUS - durationUS.

	waitUS <= 0 ifTrue: [ ^ Processor yield ].

	waitMS := (waitUS + 500) // 1000.
	waitMS > 0 ifTrue: [
		wakeUpSemaphore waitTimeoutMilliseconds: waitMS ]
]

{ #category : #lifecycle }
BlHostPulseLoop >> stop [
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

{ #category : #accessing }
BlHostPulseLoop >> valuable [

	^ valuable
]

{ #category : #accessing }
BlHostPulseLoop >> valuable: aValuable [

	valuable := aValuable
]

{ #category : #lifecycle }
BlHostPulseLoop >> wakeUp [
	"Wake up the loop process immediately if sleeping between frames, or start it if not running."

	self isRunning ifFalse: [ ^ self start ].
	wakeUpSemaphore signal
]
