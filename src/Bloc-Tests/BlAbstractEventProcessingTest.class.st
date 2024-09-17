Class {
	#name : #BlAbstractEventProcessingTest,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Tests-Universe'
}

{ #category : #testing }
BlAbstractEventProcessingTest class >> isAbstract [

	^ self == BlAbstractEventProcessingTest
]

{ #category : #asserting }
BlAbstractEventProcessingTest >> assertFiredEventIs: anEventClass target: aTarget withPropagation: aBoolean [

	| evt |
	evt := self firedEvents first.

	self
		assert: (evt isKindOf: anEventClass)
		description:
			'The event should be kind of ',
			anEventClass asString,
			' but was ', evt className.
	self
		assert: evt target = aTarget
		description:
			'The event target should be ',
			aTarget asString.
	self
		assert: evt canBePropagated = aBoolean
		description:
			'The event should ',
			(aBoolean
				ifTrue: [ '' ]
				ifFalse: [ 'not' ]),
			' be  propagated'.

	self firedEvents removeFirst
]

{ #category : #accessing }
BlAbstractEventProcessingTest >> child [

	^ self space root children at: 1
]

{ #category : #accessing }
BlAbstractEventProcessingTest >> firedEvents [

	^ self subclassResponsibility
]

{ #category : #accessing }
BlAbstractEventProcessingTest >> root [

	^ self space root
]

{ #category : #'event firing' }
BlAbstractEventProcessingTest >> sendEvent: anEvent [

	anEvent timestamp: space time now.
	space eventListener handleEvent: anEvent
]

{ #category : #'event firing' }
BlAbstractEventProcessingTest >> sendInsideTargetEvent: anEvent [

	anEvent position: 50 @ 50.
	self sendEvent: anEvent
]

{ #category : #'event firing' }
BlAbstractEventProcessingTest >> sendOutsideTargetEvent: anEvent [

	anEvent position: 150 @ 150.
	self sendEvent: anEvent
]

{ #category : #'as yet unclassified' }
BlAbstractEventProcessingTest >> setUp [

	super setUp.

	space := BlSpace new.
	space extent: 200 @ 200.
	space mouseProcessor: (BlTestMouseEventProcessor space: space).
	space focusProcessor: (BlTestFocusProcessor space: space).
	space root addChild:
		(BlElement new
			size: 100 @ 100;
			background: Color red;
			yourself).
	space pulse
]

{ #category : #accessing }
BlAbstractEventProcessingTest >> space [

	^ space
]
