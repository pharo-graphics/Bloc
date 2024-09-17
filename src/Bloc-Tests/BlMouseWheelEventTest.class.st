Class {
	#name : #BlMouseWheelEventTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Events'
}

{ #category : #running }
BlMouseWheelEventTest >> mouseWheelEventWithVector: aVector [

	| anElement |
	anElement :=
		BlElement new
			background: Color veryVeryLightGray;
			border: (BlBorder paint: Color lightGray width: 1);
			margin: (BlInsets all: 10);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.

	^ BlMouseWheelEvent new
		  vector: aVector;
		  target: anElement;
		  currentTarget: anElement;
		  yourself
]

{ #category : #tests }
BlMouseWheelEventTest >> testBasicMouseWheelEvent [

	| anEvent |
	anEvent := BlMouseWheelEvent new.
	self assert: anEvent isConsumed not
]

{ #category : #tests }
BlMouseWheelEventTest >> testMouseWheelEvent0degrees [

	| vector event |
	vector := BlVector x: 10 y: 0.
	event := self mouseWheelEventWithVector: vector.
	self assert: event vector equals: vector
]

{ #category : #tests }
BlMouseWheelEventTest >> testMouseWheelEvent180degrees [

	| vector event |
	vector := BlVector x: -10 y: 0.
	event := self mouseWheelEventWithVector: vector.
	self assert: event vector equals: vector
]

{ #category : #tests }
BlMouseWheelEventTest >> testMouseWheelEvent270degrees [

	| vector event |
	vector := BlVector x: 0 y: -10.
	event := self mouseWheelEventWithVector: vector.
	self assert: event vector equals: vector
]

{ #category : #tests }
BlMouseWheelEventTest >> testMouseWheelEvent346degrees [

	| vector event |
	vector := BlVector x: 4 y: -1.
	event := self mouseWheelEventWithVector: vector.
	self assert: event vector equals: vector
]

{ #category : #tests }
BlMouseWheelEventTest >> testMouseWheelEvent45degrees [

	| vector event |
	vector := BlVector x: 10 y: 10.
	event := self mouseWheelEventWithVector: vector.
	self assert: event vector equals: vector
]
