"
I am a mocked host that looks like real but does not create any windows

"
Class {
	#name : #BlMockedHost,
	#superclass : #BlHost,
	#classVars : [
		'isRunning'
	],
	#category : #'BlocHost-Mock-Host'
}

{ #category : #'class initialization' }
BlMockedHost class >> initialize [

	isRunning := false
]

{ #category : #'api - lifecycle' }
BlMockedHost class >> isRunning [

	^ isRunning
]

{ #category : #'api - lifecycle' }
BlMockedHost class >> start [

	isRunning := true
]

{ #category : #'api - lifecycle' }
BlMockedHost class >> stop [

	isRunning := false
]

{ #category : #'host - api' }
BlMockedHost >> newHostSpaceFor: aSpace [

	^ BlMockedHostSpace new
		host: self;
		space: aSpace;
		renderer: self newHostRenderer;
		yourself
	
]

{ #category : #'host - api' }
BlMockedHost >> wait: aBlock timeout: aDuration onCompletion: completionBlock onTimeout: timeoutBlock [
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
