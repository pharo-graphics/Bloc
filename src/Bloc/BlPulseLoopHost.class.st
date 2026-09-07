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

{ #category : #'host - testing' }
BlPulseLoopHost >> isPulseProcessActive [
	"Return true if the active process is the pulse loop process of this host"

	^ pulseLoop isNotNil and: [ pulseLoop isPulseProcessActive ]
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> isRunning [

	^ pulseLoop isRunning
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

{ #category : #'api - pulse process' }
BlPulseLoopHost >> pulseProcess [
	"Return the pulse loop Process if running, or nil."

	^ pulseLoop pulseProcess
]

{ #category : #enumerating }
BlPulseLoopHost >> pulseProcessDo: aBlock [
	"Evaluate aBlock with the running pulse Process of this host if any"

	self
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver pulseProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> start [

	pulseLoop start
]

{ #category : #'api - lifecycle' }
BlPulseLoopHost >> stop [

	pulseLoop stop
]

{ #category : #enumerating }
BlPulseLoopHost >> uiProcessDo: aBlock [

	self
		deprecated: 'Use #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver pulseProcess ifNotNil: `@arg'.

	^ self pulseProcess ifNotNil: aBlock
]
