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

{ #category : #initialization }
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
		yourself
	
]
