Class {
	#name : 'BlMouseWheelEventExamplesTest',
	#superclass : 'TestCase',
	#category : 'Bloc-Examples-Event',
	#package : 'Bloc-Examples',
	#tag : 'Event'
}

{ #category : 'examples - elements' }
BlMouseWheelEventExamplesTest >> element [

	<sampleInstance>
	| anElement |
	anElement := BlElement new.

	anElement
		background: Color veryVeryLightGray;
		border: (BlBorder paint: Color lightGray width: 1);
		margin: (BlInsets all: 10);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	^ anElement
]

{ #category : 'examples - mouse wheel events' }
BlMouseWheelEventExamplesTest >> mouseWheelEventWithVector: aVector [

	<sampleInstance>
	| anEvent anElement |
	anEvent := self testBasicMouseWheelEvent.

	anEvent vector: aVector.
	anElement := self element.
	anEvent target: anElement.
	anEvent currentTarget: anElement.
	
	^ anEvent
]

{ #category : 'examples - mouse wheel events' }
BlMouseWheelEventExamplesTest >> testBasicMouseWheelEvent [

	<sampleInstance>
	| anEvent |
	anEvent := BlMouseWheelEvent new.
	self assert: anEvent isConsumed not.
	^ anEvent
]

{ #category : 'examples - mouse wheel events' }
BlMouseWheelEventExamplesTest >> testMouseWheelEvent_0degrees [

	<sampleInstance>
	| vector event |
	vector := BlVector x: 10 y: 0.
	event := self mouseWheelEventWithVector: vector.
	self assert: event vector equals: vector.
	^ event
]

{ #category : 'examples - mouse wheel events' }
BlMouseWheelEventExamplesTest >> testMouseWheelEvent_180degrees [

	<sampleInstance>
	| vector event |
	vector := BlVector x: -10 y: 0.
	event := self mouseWheelEventWithVector: vector.
	self assert: event vector equals: vector.
	^ event
]

{ #category : 'examples - mouse wheel events' }
BlMouseWheelEventExamplesTest >> testMouseWheelEvent_270degrees [

	<sampleInstance>
	| vector event |
	vector := BlVector x: 0 y: -10.
	event := self mouseWheelEventWithVector: vector.
	self assert: event vector equals: vector.
	^ event
]

{ #category : 'examples - mouse wheel events' }
BlMouseWheelEventExamplesTest >> testMouseWheelEvent_346degrees [

	<sampleInstance>
	| vector event |
	vector := BlVector x: 4 y: -1.
	event := self mouseWheelEventWithVector: vector.
	self assert: event vector equals: vector.
	^ event
]

{ #category : 'examples - mouse wheel events' }
BlMouseWheelEventExamplesTest >> testMouseWheelEvent_45degrees [

	<sampleInstance>
	| vector event |
	vector := BlVector x: 10 y: 10.
	event := self mouseWheelEventWithVector: vector.
	self assert: event vector equals: vector.
	^ event
]
