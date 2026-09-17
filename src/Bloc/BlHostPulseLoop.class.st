"
I represent the background loop process for a `BlPulseLoopHost`, sending it `#pulse` periodically.

### Loop Timing & Rules
- `pulsePeriodMS`: The minimum duration between two consecutive pulses (framerate limit).
- If a pulse took longer than `pulsePeriodMS`, the loop either pulses again immediately or performs a brief yield if lower-priority processes may be starving.
- Senders can wake the loop process immediately via `wakeUp` (signaling `pulseRequestedSemaphore`).

### Collaborators
- `BlPulseLoopHost` (`host`): The host driven by this loop.
- `Process` (`loopProcess`): The high-priority Pharo process running the pulse loop.
"
Class {
	#name : #BlHostPulseLoop,
	#superclass : #Object,
	#instVars : [
		'host',
		'loopProcess',
		'pulsePeriodMS',
		'msToWaitForBackgroundProcess',
		'pulseDurationMS',
		'processPriority',
		'pulseRequestedSemaphore'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'instance creation' }
BlHostPulseLoop class >> host: aBlHost [

	^ self basicNew
		initializeWithHost: aBlHost;
		yourself
]

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

{ #category : #accessing }
BlHostPulseLoop >> host [

	^ host
]

{ #category : #initialization }
BlHostPulseLoop >> initializeWithHost: aBlHost [

	self initialize.

	host := aBlHost.
	pulseRequestedSemaphore := Semaphore new.
	processPriority := Processor userSchedulingPriority.

	self pulsePeriod: 15 milliSeconds
]

{ #category : #testing }
BlHostPulseLoop >> isPulseProcessActive [

	^ Processor activeProcess == loopProcess
]

{ #category : #testing }
BlHostPulseLoop >> isRunning [

	^ loopProcess isNotNil and: [ loopProcess isTerminated not ]
]

{ #category : #'loop process' }
BlHostPulseLoop >> loop [

	[ self loopIteration ] whileTrue
]

{ #category : #'loop process' }
BlHostPulseLoop >> loopIteration [

	self isRunning ifFalse: [ ^ false ].

	[
		| pulseStartMS |
		pulseRequestedSemaphore consumeAllSignals.
		pulseStartMS := Time millisecondClockValue.
		host pulse.
		pulseDurationMS := Time millisecondClockValue - pulseStartMS.

		self isRunning ifFalse: [ ^ false ].

		self waitUntilNextPulse ]
		on: Exception
		do: [ :e |
			self basicStart.
			e pass ].

	"Returns true to continue looping"
	^ self isPulseProcessActive
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

{ #category : #'loop process' }
BlHostPulseLoop >> processName [

	^ 'Bloc Host Pulse Loop ({1})' format: { host label }
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

	^ pulsePeriodMS milliSeconds
]

{ #category : #period }
BlHostPulseLoop >> pulsePeriod: aDuration [

	pulsePeriodMS := aDuration asMilliSeconds.
	msToWaitForBackgroundProcess := (pulsePeriodMS // 2) min: 1
]

{ #category : #accessing }
BlHostPulseLoop >> pulseProcess [

	^ loopProcess
]

{ #category : #lifecycle }
BlHostPulseLoop >> requestStop [
	"Request the loop process to stop gracefully at the end of the current iteration."

	loopProcess := nil
]

{ #category : #lifecycle }
BlHostPulseLoop >> start [

	self isRunning ifTrue: [ ^ self ].

	self basicStart
]

{ #category : #lifecycle }
BlHostPulseLoop >> stop [
	"Stop the loop process. Can be safely sent from any process, including the loop process itself."

	| currentProcess isCurrentActive |
	self isRunning ifFalse: [ ^ self ].

	"Store in temporary variable to support stopping from the loopProcess itself"
	isCurrentActive := self isPulseProcessActive.
	currentProcess := loopProcess.
	loopProcess := nil.

	isCurrentActive ifFalse: [ currentProcess terminate ]
]

{ #category : #period }
BlHostPulseLoop >> waitUntilNextPulse [
	"Wait the appropriate amount of time for the next pulse"

	| msToWait |
	"Since a pulse can take longer than #pulsePeriod, msToWait may be negative or zero here
	(meaning that we shouldn't wait for the next pulse)"
	msToWait := pulsePeriodMS - pulseDurationMS.

	"Even if there is no need to wait, yield to other processes of the same priority"
	msToWait <= 0 ifTrue: [ ^ Processor yield ].

	"Wait until the next scheduled pulse period or until a pulse is requested explicitly"
	pulseRequestedSemaphore waitTimeoutMilliseconds: msToWait
]

{ #category : #period }
BlHostPulseLoop >> wakeUp [
	"Wake up the loop process immediately if sleeping between frames, or start it if not running."

	self isRunning ifFalse: [ ^ self start ].
	pulseRequestedSemaphore signal
]
