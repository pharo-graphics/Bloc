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
		'hostClass',
		'loopProcess',
		'pulsePeriodMS',
		'waitingDelay',
		'msToWaitForBackgroundProcess',
		'latestPulseMS'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'instance creation' }
BlHostPulseLoop class >> forHost: aHostClass [

	^ self basicNew
		  initialize;
		  hostClass: aHostClass;
		  yourself
]

{ #category : #'instance creation' }
BlHostPulseLoop class >> new [

	self error: 'Use #forHost: instead'
]

{ #category : #accessing }
BlHostPulseLoop class >> processId [

	^ 'Bloc Main Loop'
]

{ #category : #period }
BlHostPulseLoop >> defaultPulsePeriod [

	^ 15 milliSeconds
]

{ #category : #'as yet unclassified' }
BlHostPulseLoop >> forceStartNewUIProcess [
	"I should only be used by the logic for opening the debugger.
	
	I create and start a new UI thread without stopping the previous one.
	Normally this leads to incorrect behaviou in Bloc UI process. However 
	if I am called from the current Bloc UI process when an error happened in 
	the actual process, and after calling me my sender terminates or suspends 
	the process my usage should be safe."
	
	loopProcess := self newLoopProcess.
	loopProcess resume.
]

{ #category : #'as yet unclassified' }
BlHostPulseLoop >> forceStartOfUIProcess: aProces [
	"I should only be used by the logic for closing the debugger."
	
	loopProcess := aProces.
	loopProcess resume.
]

{ #category : #accessing }
BlHostPulseLoop >> hostClass [

	^ hostClass
]

{ #category : #accessing }
BlHostPulseLoop >> hostClass: aHostClass [

	hostClass := aHostClass
]

{ #category : #initialization }
BlHostPulseLoop >> initialize [

	super initialize.

	self pulsePeriod: self defaultPulsePeriod.

	"This initializes the internal Semaphore, but the milliseconds
	to wait are set after each pulse."
	waitingDelay := Delay forMilliseconds: 0.
]

{ #category : #testing }
BlHostPulseLoop >> isRunning [

	^ loopProcess isNotNil and: [ loopProcess isTerminated not ]
]

{ #category : #testing }
BlHostPulseLoop >> isRunningInTheSameProcess [

	^ Processor activeProcess effectiveProcess == loopProcess
]

{ #category : #accessing }
BlHostPulseLoop >> loopProcess [

	^ loopProcess
]

{ #category : #'loop process' }
BlHostPulseLoop >> newLoopBlock [

	^ [ [ latestPulseMS := Time millisecondClockValue.

			(BlParallelUniverse forHost: hostClass) pulse.

			self waitUntilNextPulse 
		
		] doWhileTrue: [ loopProcess == Processor activeProcess ] ]
]

{ #category : #'loop process' }
BlHostPulseLoop >> newLoopProcess [

	^ self newLoopBlock newProcess
		priority: 40;
		name: self processId;
		yourself
]

{ #category : #'loop process' }
BlHostPulseLoop >> processId [

	^ self class processId
]

{ #category : #period }
BlHostPulseLoop >> pulsePeriod [

	^ pulsePeriodMS milliSeconds
]

{ #category : #period }
BlHostPulseLoop >> pulsePeriod: aDuration [

	pulsePeriodMS := aDuration asMilliSeconds.
	msToWaitForBackgroundProcess := (pulsePeriodMS // 2) min: 1.
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
	
	currentProcess := loopProcess.
	loopProcess := nil.
	currentProcess terminate
]

{ #category : #period }
BlHostPulseLoop >> waitUntilNextPulse [
	"Wait the appropriate amount of time for the next pulse"

	| msToWait shouldForceDelay minWaitMS |
	"msToWait is the amount of time to wait for the next pulse.
	Since a pulse can take longer than #pulsePeriod, msToWait may be negative here
	(meaning that we shouldn't wait for the next pulse)"
	msToWait := pulsePeriodMS - (Time millisecondClockValue - latestPulseMS).

	"But also ensure that background processes get some execution time.
	If the nextReadyProcess has more priority than the IDLE process"
	shouldForceDelay :=
		Processor nextReadyProcess priority > Processor lowestPriority.
	minWaitMS :=
		shouldForceDelay
			ifTrue: [ msToWaitForBackgroundProcess ]
			ifFalse: [ 0 ].

	BlPulseStatSignal milliseconds: msToWait delayForced: shouldForceDelay.

	msToWait := msToWait min: pulsePeriodMS max: minWaitMS.

	msToWait = 0 ifFalse: [ waitingDelay setDelay: msToWait; wait ]

]
