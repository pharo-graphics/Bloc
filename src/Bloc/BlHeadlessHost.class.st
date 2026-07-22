"
I am a mocked host that looks like real but does not create any windows

"
Class {
	#name : #BlHeadlessHost,
	#superclass : #BlHost,
	#classInstVars : [
		'pulseLoop'
	],
	#category : #'Bloc-Universe - Host Headless'
}

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> isRunning [

	^ self pulseLoop isRunning
]

{ #category : #printing }
BlHeadlessHost class >> label [

	^ 'Headless'
]

{ #category : #'driver selection' }
BlHeadlessHost class >> priority [
	"Infinite priority means that I am selected only if there are no other available hosts"

	^ Float infinity
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> pulsePeriod [

	^ self pulseLoop pulsePeriod
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> pulsePeriod: aDuration [

	self pulseLoop pulsePeriod: aDuration
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> start [

	self pulseLoop start
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> stop [

	self pulseLoop stop
]

{ #category : #'api - ui process' }
BlHeadlessHost class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"

	self pulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #accessing }
BlHeadlessHost class >> pulseLoop [

	^ pulseLoop ifNil: [ pulseLoop := BlHostPulseLoop forHost: self ]
]

{ #category : #cleanup }
BlHeadlessHost class >> cleanUp [
	super cleanUp.
	pulseLoop := nil
]

{ #category : #'host - api' }
BlHeadlessHost >> newHostSpaceFor: aSpace [

	^ BlHeadlessHostSpace new
		host: self;
		universe: self universe;
		space: aSpace;
		renderer: self newHostRenderer;
		windowExtent: aSpace extent;
		canvasExtent: aSpace extent;
		yourself
]
