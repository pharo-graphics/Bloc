Class {
	#name : #BlMouseWheelEventExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'examples - mouse wheel events' }
BlMouseWheelEventExamples >> basicMouseWheelEvent [
	<gtExample>
	| anEvent |
	anEvent := BlMouseWheelEvent new.
	self assert: anEvent isConsumed not.
	^ anEvent
]

{ #category : #'examples - elements' }
BlMouseWheelEventExamples >> element [
	<gtExample>
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

{ #category : #'examples - mouse wheel events' }
BlMouseWheelEventExamples >> mouseWheelEventWithVector: aVector [
	<gtExample>
	| anEvent anElement |
	anEvent := self basicMouseWheelEvent.

	anEvent vector: aVector.
	anElement := self element.
	anEvent target: anElement.
	anEvent currentTarget: anElement.
	
	self assert: anEvent vector equals: aVector.
	^ anEvent
]

{ #category : #'examples - mouse wheel events' }
BlMouseWheelEventExamples >> mouseWheelEvent_0degrees [
	<gtExample>
	^ self mouseWheelEventWithVector: (BlVector x: 10 y: 0).
]

{ #category : #'examples - mouse wheel events' }
BlMouseWheelEventExamples >> mouseWheelEvent_180degrees [
	<gtExample>
	^ self mouseWheelEventWithVector: (BlVector x: -10 y: 0).
]

{ #category : #'examples - mouse wheel events' }
BlMouseWheelEventExamples >> mouseWheelEvent_270degrees [
	<gtExample>
	^ self mouseWheelEventWithVector: (BlVector x: 0 y: -10).
]

{ #category : #'examples - mouse wheel events' }
BlMouseWheelEventExamples >> mouseWheelEvent_346degrees [
	<gtExample>
	^ self mouseWheelEventWithVector: (BlVector x: 4 y: -1).
]

{ #category : #'examples - mouse wheel events' }
BlMouseWheelEventExamples >> mouseWheelEvent_45degrees [
	<gtExample>
	^ self mouseWheelEventWithVector: (BlVector x: 10 y: 10).
]
