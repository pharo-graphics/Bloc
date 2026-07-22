"
I am an abstract host for loop-based pulse loops.
I define the class-side instance variable `pulseLoop` and delegate standard lifecycle methods to it.
"
Class {
	#name : #BlPulseLoopHost,
	#superclass : #BlHost,
	#classInstVars : [
		'pulseLoop'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'api - lifecycle' }
BlPulseLoopHost class >> isRunning [

	^ self pulseLoop isRunning
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost class >> pulsePeriod [

	^ self pulseLoop pulsePeriod
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost class >> pulsePeriod: aDuration [

	self pulseLoop pulsePeriod: aDuration
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost class >> start [

	self pulseLoop start
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost class >> stop [

	self pulseLoop stop
]

{ #category : #'api - ui process' }
BlPulseLoopHost class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"

	self pulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #accessing }
BlPulseLoopHost class >> pulseLoop [

	^ pulseLoop ifNil: [ pulseLoop := BlHostPulseLoop forHost: self ]
]

{ #category : #cleanup }
BlPulseLoopHost class >> cleanUp [
	super cleanUp.
	pulseLoop := nil
]
