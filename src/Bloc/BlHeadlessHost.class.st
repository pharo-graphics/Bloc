"
I am a mocked host that looks like real but does not create any windows

"
Class {
	#name : #BlHeadlessHost,
	#superclass : #BlHost,
	#classVars : [
		'PulseLoop',
		'isRunning'
	],
	#category : #'Bloc-Universe - Host Headless'
}

{ #category : #'class initialization' }
BlHeadlessHost class >> initialize [

	PulseLoop := BlHostPulseLoop forHost: self.
	isRunning := false
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> isRunning [

	^ PulseLoop isRunning
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

	^ PulseLoop pulsePeriod
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> pulsePeriod: aDuration [

	PulseLoop pulsePeriod: aDuration
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> start [

	PulseLoop start.
	isRunning := true
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> stop [

	PulseLoop stop.
	isRunning := false
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
	
	PulseLoop loopProcess ifNotNil: aBlock
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

{ #category : #'host - api' }
BlHeadlessHost >> wait: aBlock timeout: aDuration onCompletion: completionBlock onTimeout: timeoutBlock [
	"A mocked host has no background loop: manually pulse and yield a tiny bit"
	| deadline timeProvider |
	timeProvider := self universe spaces
		ifNotEmpty: [ :theSpaces | theSpaces first time ]
		ifEmpty: [ BlTime real ].
	deadline := timeProvider now + aDuration.

	[ aBlock value ] whileTrue: [
		timeProvider now >= deadline ifTrue: [ ^ timeoutBlock value ].
		self universe pulse.
		(Delay forMilliseconds: 1) wait ].

	^ completionBlock value
]
