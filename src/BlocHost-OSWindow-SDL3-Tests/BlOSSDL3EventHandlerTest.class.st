"
I test BlOSSDL3EventHandler event handling and repeat normalization.
"
Class {
	#name : #BlOSSDL3EventHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'handler',
		'enqueuedEvents'
	],
	#category : #'BlocHost-OSWindow-SDL3-Tests'
}

{ #category : #accessing }
BlOSSDL3EventHandlerTest >> enqueueEvent: anEvent [

	enqueuedEvents add: anEvent
]

{ #category : #accessing }
BlOSSDL3EventHandlerTest >> logicalSize [

	^ (800 @ 600) asLogicalSize
]

{ #category : #running }
BlOSSDL3EventHandlerTest >> setUp [
	super setUp.
	enqueuedEvents := OrderedCollection new.
	handler :=
		BlOSSDL3EventHandler
			window: self
			time: BlTime real
			keyboardKeyTable: BlOSSDL3KeyTable new
]

{ #category : #tests }
BlOSSDL3EventHandlerTest >> testVisitKeyDownEventInitial [

	| osEvent |
	osEvent :=
		OSKeyDownEvent new
			scanCode: 4;
			symbol: 97;
			repeat: 0;
			yourself.

	handler visitKeyDownEvent: osEvent.

	self assert: enqueuedEvents size equals: 1.
	self deny: enqueuedEvents first isRepeated
]

{ #category : #tests }
BlOSSDL3EventHandlerTest >> testVisitKeyDownEventRepeat [

	| osEvent |
	osEvent :=
		OSKeyDownEvent new
			scanCode: 4;
			symbol: 97;
			repeat: 1;
			yourself.

	handler visitKeyDownEvent: osEvent.

	self assert: enqueuedEvents size equals: 1.
	self assert: enqueuedEvents first isRepeated
]

{ #category : #tests }
BlOSSDL3EventHandlerTest >> testVisitWindowResolutionChangeEvent [

	handler visitWindowResolutionChangeEvent: OSWindowResolutionChangeEvent new.

	self assert: enqueuedEvents size equals: 1.
	self assert: enqueuedEvents first class equals: BlSpaceResizedEvent.
	self assert: enqueuedEvents first extent equals: 800 @ 600
]
