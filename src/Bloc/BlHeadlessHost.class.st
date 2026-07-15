"
I am a mocked host that looks like real but does not create any windows

"
Class {
	#name : #BlHeadlessHost,
	#superclass : #BlHost,
	#classVars : [
		'isRunning'
	],
	#category : #'Bloc-Universe - Host Headless'
}

{ #category : #'class initialization' }
BlHeadlessHost class >> initialize [

	isRunning := false
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> isRunning [

	^ isRunning
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
BlHeadlessHost class >> start [

	isRunning := true
]

{ #category : #'api - lifecycle' }
BlHeadlessHost class >> stop [

	isRunning := false
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
	deadline := aDuration ifNotNil: [ timeProvider now + aDuration ].

	[ aBlock value ] whileTrue: [
		(deadline notNil and: [ timeProvider now >= deadline ]) ifTrue: [ ^ timeoutBlock value ].
		self universe pulse.
		(Delay forMilliseconds: 1) wait ].

	^ completionBlock value
]

{ #category : #'host - testing' }
BlHeadlessHost >> waitEmptyTaskQueueFor: aSpace timeout: aDuration [
	| finished |
	finished := false.
	self
		wait: [ 
			self universe pulse.
			aSpace pulse.
			aSpace hasPendingWork ]
		timeout: aDuration
		onCompletion: [ finished := true ]
		onTimeout: [ finished := false ].
	^ finished
]
