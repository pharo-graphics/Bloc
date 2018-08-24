"
I am the Bloc main loop.
I indicate to the Universe that is time to synchronize the state of the elements. 

A pulse is fired all the 16ms to obtain 60 frames per second (fps) maximum.
The opened spaces listen the pulse to be synchronized and to update their state when it is needed.
"
Class {
	#name : #BlPulseService,
	#superclass : #TKTService,
	#instVars : [
		'pulseEvent',
		'pulseStartTime',
		'lastElpasedTime',
		'pulsePeriod',
		'session'
	],
	#category : 'Bloc-ThreadSupport'
}

{ #category : #period }
BlPulseService >> defaultPulsePeriod [
	^ 16
]

{ #category : #'as yet unclassified' }
BlPulseService >> kill [

	worker stop
]

{ #category : #accessing }
BlPulseService >> lastElpasedTime [
	^ lastElpasedTime
]

{ #category : #period }
BlPulseService >> loopProcess [
	^ self worker process process
]

{ #category : #'as yet unclassified' }
BlPulseService >> name [
	^ 'Bloc Main Loop'
]

{ #category : #accessing }
BlPulseService >> pulseEvent [
	^ pulseEvent 
]

{ #category : #period }
BlPulseService >> pulsePeriod [
^ pulsePeriod ifNil: [pulsePeriod :=self defaultPulsePeriod]
]

{ #category : #period }
BlPulseService >> pulsePeriod: aTime [
	pulsePeriod := aTime
]

{ #category : #'as yet unclassified' }
BlPulseService >> setUp [
	super setUp.
	pulseEvent := BlPulseEvent new.
	session := Smalltalk session.
	lastElpasedTime := 0.
	pulseStartTime := 0.
]

{ #category : #'as yet unclassified' }
BlPulseService >> stepService [
	(session == Smalltalk session) ifFalse:[^ self kill].
	pulseStartTime := Time millisecondClockValue.
	BlUniverse default firePulse: self pulseEvent.
	self wait.
	Processor yield
]

{ #category : #'as yet unclassified' }
BlPulseService >> tearDown [
	super tearDown
]

{ #category : #period }
BlPulseService >> timeIsUp [
	^ pulseStartTime isNotNil
		and: [ Time millisecondClockValue - pulseStartTime > self pulsePeriod ]
]

{ #category : #period }
BlPulseService >> wait [
	| milliSecs |
	milliSecs := (self pulsePeriod - (Time millisecondClockValue - pulseStartTime)) min:16 max:1.
	(Delay forMilliseconds: milliSecs) wait.
	lastElpasedTime := Time millisecondClockValue.
]
