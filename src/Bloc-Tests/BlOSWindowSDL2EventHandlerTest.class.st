"
I test BlOSWindowSDL2EventHandler event handling and repeat normalization.
"
Class {
	#name : #BlOSWindowSDL2EventHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'handler',
		'enqueuedEvents'
	],
	#category : #'Bloc-Tests'
}

{ #category : #accessing }
BlOSWindowSDL2EventHandlerTest >> enqueueEvent: anEvent [

	enqueuedEvents add: anEvent
]

{ #category : #running }
BlOSWindowSDL2EventHandlerTest >> setUp [
	super setUp.
	enqueuedEvents := OrderedCollection new.
	handler :=
		BlOSWindowSDL2EventHandler
			window: self
			time: BlTime real
			keyboardKeyTable: BlOSWindowSDL2KeyboardKeyTable new
]

{ #category : #tests }
BlOSWindowSDL2EventHandlerTest >> testVisitKeyDownEventInitial [

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
BlOSWindowSDL2EventHandlerTest >> testVisitKeyDownEventRepeat [

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
