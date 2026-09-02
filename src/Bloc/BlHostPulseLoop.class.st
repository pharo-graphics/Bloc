"
I represent the main loop of a host class, that sends it #pulse regularly.

My loop follows the next rules:
- The #pulsePeriod duration is the minimum amount of time between two subsequent sends of #pulse.
- If a pulse took more time than #pulsePeriod, then the next pulse may either send the next #pulse immediately, or do a small wait before if another process with lower priority is suspended (and may be starving).

The opened spaces listen the pulse to be synchronized and to update their state when it is needed.

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
		'processPriority'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'instance creation' }
BlHostPulseLoop class >> host: aBlHost [

	^ self basicNew
		initializeWithHost: aBlHost;
		yourself
]

{ #category : #debug }
BlHostPulseLoop >> forceStartNewPulseProcess [
	"I should only be used by the logic for opening the debugger.
	
	I create and start a new pulse process without stopping the previous one.
	Normally this leads to incorrect behaviour in Bloc pulse process. However 
	if I am sent from the current Bloc pulse process when an error happened in 
	the actual process, and after sending me, my sender terminates or suspends 
	the process my usage should be safe."
	
	loopProcess := self newLoopProcess.
	loopProcess resume
]

{ #category : #debug }
BlHostPulseLoop >> forceStartNewUIProcess [

	self
		deprecated: 'Use #forceStartNewPulseProcess instead'
		transformWith: '`@receiver forceStartNewUIProcess' -> '`@receiver forceStartNewPulseProcess'.

	^ self forceStartNewPulseProcess
]

{ #category : #debug }
BlHostPulseLoop >> forceStartOfPulseProcess: aProcess [
	"I should only be used by the logic for closing the debugger."
	
	loopProcess := aProcess.
	loopProcess resume
]

{ #category : #debug }
BlHostPulseLoop >> forceStartOfUIProcess: aProces [

	self
		deprecated: 'Use #forceStartOfPulseProcess: instead'
		transformWith: '`@receiver forceStartOfUIProcess: `@arg' -> '`@receiver forceStartOfPulseProcess: `@arg'.

	^ self forceStartOfPulseProcess: aProces
]

{ #category : #accessing }
BlHostPulseLoop >> host [

	^ host
]

{ #category : #initialization }
BlHostPulseLoop >> initializeWithHost: aBlHost [

	self initialize.

	host := aBlHost.
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

	[	| pulseStartMS |
		pulseStartMS := Time millisecondClockValue.
		host universe pulse.
		pulseDurationMS := Time millisecondClockValue - pulseStartMS.
		self waitUntilNextPulse ]
	on: Exception
	do: [ :e |
		self forceStartNewPulseProcess.
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

	^ 'Bloc Host Loop ({1})' format: { host }
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
BlHostPulseLoop >> start [

	self isRunning ifTrue: [ ^ self ].

	loopProcess := self newLoopProcess.
	loopProcess resume
]

{ #category : #lifecycle }
BlHostPulseLoop >> stop [

	| currentProcess |
	self isRunning ifFalse: [ ^ self ].
	
	"Store in temporary variable to support stopping from the loopProcess itself"
	currentProcess := loopProcess.
	loopProcess := nil.
	currentProcess terminate
]

{ #category : #period }
BlHostPulseLoop >> waitUntilNextPulse [
	"Wait the appropriate amount of time for the next pulse"

	| msToWait |
	"Since a pulse can take longer than #pulsePeriod, msToWait may be negative here
	(meaning that we shouldn't wait for the next pulse)"
	msToWait := pulsePeriodMS - pulseDurationMS.

	"Even if there is no need to wait, yield to other processes of the same priority"
	msToWait <= 0 ifTrue: [ ^ Processor yield ].
	
	"We need to wait"
	(Delay forMilliseconds: msToWait) wait
]
