"
I am the Bloc main loop.
I indicate to the Universe that is time to synchronize the state of the elements. 

A pulse is fired all the 16ms to obtain 60 frames per second (fps) maximum.
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
	^ [ [ [ self firePulse ] on: Error do: [ :anError | ] ] repeat ]
]

{ #category : #period }
BlPulseLoop >> defaultPulsePeriod [
	^ 16 milliSeconds
]

{ #category : #'loop process' }
BlPulseLoop >> firePulse [
	pulseStartTime := DateAndTime now.
	self pulseEvent timestamp: pulseStartTime.
	BlUniverse default firePulse: self pulseEvent.
	self wait.
	Processor yield
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
	"Do not pause UI thread if there are no background tasks. UI becomes much smoother
(Processor nextReadyProcess == Processor backgroundProcess)
		ifFalse: [ (Delay forMilliseconds: milliSecs) wait ]."
	| milliSecs |
	milliSecs := (self pulsePeriod - (DateAndTime now - pulseStartTime)) min: 16 milliSeconds max: 0 milliSeconds.
	milliSecs isZero
		ifFalse: [ milliSecs wait ].

	lastElpasedTime := DateAndTime now
]
