"
I am an abstract host for loop-based pulse loops.
I define the class-side instance variable `pulseLoop` and delegate standard lifecycle methods to it.
"
Class {
	#name : #BlPulseLoopHost,
	#superclass : #BlHost,
	#instVars : [
		'pulseLoop'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #initialization }
BlPulseLoopHost >> initialize [

	super initialize.
	pulseLoop := BlHostPulseLoop host: self
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> isRunning [

	^ pulseLoop isRunning
]

{ #category : #'host - testing' }
BlPulseLoopHost >> isUIProcess [
	"Return true if the active process is the UI loop process of this host"

	^ pulseLoop isNotNil and: [ pulseLoop isRunningInActiveProcess ]
]

{ #category : #accessing }
BlPulseLoopHost >> pulseLoop [

	^ pulseLoop
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> pulsePeriod [

	^ pulseLoop pulsePeriod
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> pulsePeriod: aDuration [

	pulseLoop pulsePeriod: aDuration
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> start [

	pulseLoop start
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> stop [

	pulseLoop stop
]

{ #category : #'api - ui process' }
BlPulseLoopHost >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"

	pulseLoop loopProcess ifNotNil: aBlock
]
