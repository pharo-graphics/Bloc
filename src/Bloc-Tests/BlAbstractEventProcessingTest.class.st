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

{ #category : #asserting }
BlAbstractEventProcessingTest >> assertNextFiredEventIs: anEventClass target: aTarget [

	| nextEvent |
	self deny: self firedEvents isEmpty.
	
	nextEvent := self firedEvents removeFirst.
	self assert: nextEvent class equals: anEventClass.
	self assert: nextEvent target equals: aTarget
]

{ #category : #accessing }
BlAbstractEventProcessingTest >> childA [

	^ space root childWithId: #A
]

{ #category : #accessing }
BlAbstractEventProcessingTest >> childB [

	^ space root childWithId: #B
]

{ #category : #accessing }
BlAbstractEventProcessingTest >> childBA [

	^ self childB childWithId: #BA
]

{ #category : #accessing }
BlAbstractEventProcessingTest >> firedEvents [

	^ self subclassResponsibility
]

{ #category : #accessing }
BlAbstractEventProcessingTest >> root [

	^ space root
]

{ #category : #'event firing' }
BlAbstractEventProcessingTest >> sendEvent: anEvent [

	anEvent fillFromTime: space time.

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

{ #category : #running }
BlAbstractEventProcessingTest >> setUp [

	super setUp.

	space := BlSpace new.
	space extent: 200 @ 200.
	space mouseProcessor: (BlTestMouseEventProcessor space: space).
	space focusProcessor: (BlTestFocusProcessor space: space).
	space root addChild:
		(BlElement new
			id: #A;
			size: 100 @ 100;
			background: Color red;
			yourself).
	space root addChild:
		(BlElement new
			id: #B;
			position: 100 @ 0;
			size: 100 @ 100;
			background: Color green;
			addChild:
				(BlElement new
					id: #BA;
					size: 50 @ 50;
					background: Color blue;
					yourself)
			yourself).
	space pulse
]

{ #category : #accessing }
BlAbstractEventProcessingTest >> space [

	^ space
]
