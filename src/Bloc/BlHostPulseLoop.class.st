"
I am a rate-capped execution loop that periodically evaluates an action valuable in a dedicated background process (#start, #stop, #basicStart).

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
		'stopRequested',
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
	processName := 'Bloc Host Pulse Loop'.
	stopRequested := false
]

{ #category : #testing }
BlHostPulseLoop >> isRunning [

	^ stopRequested not and: [ loopProcess isNotNil and: [ loopProcess isTerminated not ] ]
]

{ #category : #'loop process' }
BlHostPulseLoop >> loop [

	[ self loopIteration ] whileTrue
]

{ #category : #'loop process' }
BlHostPulseLoop >> loopIteration [

	self isRunning ifFalse: [ ^ false ].

	[
		| startUS |
		wakeUpSemaphore consumeAllSignals.
		startUS := Time microsecondClockValue.

		valuable value.

		lastUS := Time microsecondClockValue.
		durationUS := lastUS - startUS.

		self isRunning ifFalse: [ ^ false ].

		self waitUntilNextPulse
	] on: Exception do: [ :e |
		self basicStart.
		e pass ].

	^ self ownsActiveProcess
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

{ #category : #testing }
BlHostPulseLoop >> ownsActiveProcess [

	^ Processor activeProcess == loopProcess
]

{ #category : #period }
BlHostPulseLoop >> period [

	^ periodUS microSeconds
]

{ #category : #period }
BlHostPulseLoop >> period: aDuration [

	periodUS := aDuration asMicroseconds max: 1
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

	stopRequested := true.
	loopProcess := nil
]

{ #category : #lifecycle }
BlHostPulseLoop >> start [

	self isRunning ifTrue: [ ^ self ].

	stopRequested := false.
	self basicStart
]

{ #category : #lifecycle }
BlHostPulseLoop >> stop [
	"Stop the loop process. Can be safely sent from any process, including the loop process itself."

	| currentProcess isCurrentActive |
	self isRunning ifFalse: [ ^ self ].

	stopRequested := true.
	isCurrentActive := self ownsActiveProcess.
	currentProcess := loopProcess.
	loopProcess := nil.

	isCurrentActive ifFalse: [
		currentProcess ifNotNil: [ currentProcess terminate ] ]
]

{ #category : #accessing }
BlHostPulseLoop >> stopRequested [

	^ stopRequested
]

{ #category : #accessing }
BlHostPulseLoop >> valuable [

	^ valuable
]

{ #category : #accessing }
BlHostPulseLoop >> valuable: aValuable [

	valuable := aValuable
]

{ #category : #period }
BlHostPulseLoop >> waitUntilNextPulse [
	"Wait the appropriate amount of time for the next pulse."

	| waitUS waitMS |
	waitUS := periodUS - durationUS.
	waitUS <= 0 ifTrue: [ ^ Processor yield ].

	waitMS := (waitUS + 500) // 1000.
	waitMS > 0 ifTrue: [
		wakeUpSemaphore waitTimeoutMilliseconds: waitMS ]
]

{ #category : #lifecycle }
BlHostPulseLoop >> wakeUp [
	"Wake up the loop process immediately if sleeping between frames, or start it if not running."

	self isRunning ifFalse: [ ^ self start ].
	wakeUpSemaphore signal
]
