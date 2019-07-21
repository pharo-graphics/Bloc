"
I am the Bloc main loop.
I indicate to the Universe that is time to synchronize the state of the elements. 

A pulse is fired every 16ms (if possible) to obtain 60 frames per second (fps) maximum.  This may be delayed if there are background processes wanting to run (to ensure that background calculation of UI elements can complete).  See ${method:name=BlPulseLoop>>#wait} for details of how the loop time is regulated.

The opened spaces listen the pulse to be synchronized and to update their state when it is needed.
"
Class {
	#name : #BlPulseLoop,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'pulseEvent',
		'pulseStartTime',
		'lastElpasedTime',
		'waitingDelay',
		'loopProcess',
		'pulsePeriod',
		'session'
	],
	#category : #'Bloc-Universe'
}

{ #category : #'loop process' }
BlPulseLoop >> createLoopProcess [
	^ self createLoopTask newProcess
		priority: BlUniverse default mainLoopPriority;
		name: self processId;
		yourself
]

{ #category : #'loop process' }
BlPulseLoop >> createLoopTask [
	^ [ [ self firePulse ] repeat ]
]

{ #category : #period }
BlPulseLoop >> defaultPulsePeriod [
	^ 15 milliSeconds
]

{ #category : #'loop process' }
BlPulseLoop >> firePulse [
	pulseStartTime := DateAndTime now.
	self pulseEvent timestamp: pulseStartTime.
	"BlUniverse default firePulse: self pulseEvent."
	self wait.
	Processor yield
]

{ #category : #'as yet unclassified' }
BlPulseLoop >> forceStartNewUIProcess [
	"I should only be used by the logic for opening the debugger.
	
	I create and start a new UI thread without stopping the previous one.
	Normally this leads to incorrect behaviou in Bloc UI process. However 
	if I am called from the current Bloc UI process when an error happened in 
	the actual process, and after calling me my sender terminates or suspends 
	the process my usage should be safe."
	
	loopProcess := self createLoopProcess.
	loopProcess resume.
]

{ #category : #'as yet unclassified' }
BlPulseLoop >> forceStartOfUIProcess: aProces [
	"I should only be used by the logic for closing the debugger."
	
	loopProcess := aProces.
	loopProcess resume.
]

{ #category : #initialization }
BlPulseLoop >> initialize [
	super initialize.
	pulseEvent := BlPulseEvent new.
	lastElpasedTime := 0.
	pulseStartTime := DateAndTime now.
]

{ #category : #testing }
BlPulseLoop >> isRunning [
	^ loopProcess isNotNil and: [ loopProcess isTerminated not ]
]

{ #category : #testing }
BlPulseLoop >> isRunningInTheSameProcess [
	^ Processor activeProcess effectiveProcess == loopProcess
]

{ #category : #accessing }
BlPulseLoop >> lastElpasedTime [
	^ lastElpasedTime
]

{ #category : #accessing }
BlPulseLoop >> loopProcess [
	^ loopProcess
]

{ #category : #'loop process' }
BlPulseLoop >> processId [
	^ 'Bloc Main Loop'
]

{ #category : #accessing }
BlPulseLoop >> pulseEvent [
	^ pulseEvent 
]

{ #category : #period }
BlPulseLoop >> pulsePeriod [
	^ pulsePeriod ifNil: [ pulsePeriod := self defaultPulsePeriod ]
]

{ #category : #period }
BlPulseLoop >> pulsePeriod: aTime [
	^ pulsePeriod := aTime
]

{ #category : #lifecycle }
BlPulseLoop >> start [
	self isRunning
		ifTrue: [ ^ self ].

	self
		assert: [ loopProcess isNil ]
		description: [ 'Loop process must not exist' ].

	loopProcess := self createLoopProcess.
	loopProcess resume
]

{ #category : #lifecycle }
BlPulseLoop >> stop [
	| currentProcess |
	
	self isRunning
		ifFalse: [ ^ self ].
	
	self
		assert: [ loopProcess isNotNil ]
		description: [ 'Loop process must exist!' ].

	currentProcess := loopProcess.
	loopProcess := nil.
	currentProcess terminate
]

{ #category : #period }
BlPulseLoop >> timeIsUp [
	^ DateAndTime now - pulseStartTime > self pulsePeriod
]

{ #category : #period }
BlPulseLoop >> wait [
	"Wait the appropriate amount of time for the next pulse"

	| milliSecs forceDelay maxWait |

	"milliSecs is the amount of time to wait for the next pulse.
	Since a pulse can take longer than #pulsePeriod (16ms) milliSecs may be negative here
	(meaning that we shouldn't wait for the next pulse)"
	milliSecs := (self pulsePeriod - (DateAndTime now - pulseStartTime)).
	"But also ensure that background processes get some execution time.
	If the nextReadyProcess has a priority of 10 it is the idle process and we don't need to wait"
	forceDelay := Processor nextReadyProcess priority > 10.
	maxWait := forceDelay
			ifTrue: [ self pulsePeriod // 2 ]
			ifFalse: [ 0 milliSeconds ].
	BlPulseStatSignal duration: milliSecs delayForced: forceDelay.
	milliSecs := milliSecs min: self pulsePeriod max: maxWait.
	milliSecs isZero ifFalse: [ milliSecs wait ].

	lastElpasedTime := DateAndTime now
]
