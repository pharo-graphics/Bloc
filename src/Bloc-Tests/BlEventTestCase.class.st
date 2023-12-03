Class {
	#name : #BlEventTestCase,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : 'Bloc-Tests-Universe'
}

{ #category : #asserting }
BlEventTestCase >> assertFiredEventIs: anEventClass target: aTarget withPropagation: aBoolean [
	| evt |
	evt := self firedEvents first.
	
	self assert: (evt isKindOf: anEventClass) description: 'The event should be kind of ', anEventClass asString, ' but was ', evt className.
	self assert: evt target = aTarget description: 'The event target should be  ', aTarget asString.
	self assert: evt canBePropagated = aBoolean description: ('The event should ', (aBoolean ifTrue:[''] ifFalse:['not']), ' be  propagated').
	
	self firedEvents removeFirst
]

{ #category : #accessing }
BlEventTestCase >> child [
	^ self space root children at: 1
]

{ #category : #accessing }
BlEventTestCase >> firedEvents [
	^ space mouseProcessor firedEvents
]

{ #category : #accessing }
BlEventTestCase >> root [
	^ self space root
]

{ #category : #'event firing' }
BlEventTestCase >> sendEvent: anEvent [
	anEvent timestamp: DateAndTime now.
	space eventListener handleEvent: anEvent
]

{ #category : #'event firing' }
BlEventTestCase >> sendInsideTargetEvent: anEvent [
	anEvent position: 50 @ 50.
	self sendEvent: anEvent
]

{ #category : #'event firing' }
BlEventTestCase >> sendOutsideTargetEvent: anEvent [
	anEvent position: 150 @ 150.
	self sendEvent: anEvent
]

{ #category : #initialization }
BlEventTestCase >> setUp [
	
	super setUp.
	
	space := BlSpace new.
	space extent: 200 @ 200.
	space mouseProcessor: (BlTestMouseEventProcessor space: space).
	space focusProcessor: (BlTestFocusProcessor space: space).
	space root addChild: (BlElement new size: 100 @ 100; background: Color red).
	space pulse
]

{ #category : #accessing }
BlEventTestCase >> space [
	^ space
]
