"
I represent a single metrics element (margin or padding or border).
I can contain sub metrics element

"
Class {
	#name : 'BlMetricsInspectorElement',
	#superclass : 'BlElement',
	#instVars : [
		'contentElement',
		'topInsetElement',
		'rightInsetElement',
		'bottomInsetElement',
		'leftInsetElement',
		'labelElement',
		'spacing'
	],
	#category : 'Bloc-DevTool-Metrics',
	#package : 'Bloc-DevTool',
	#tag : 'Metrics'
}

{ #category : 'accessing' }
BlMetricsInspectorElement >> content: anElement [
	contentElement := anElement.
	contentElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter. ].
	self addChild: contentElement
]

{ #category : 'initialization' }
BlMetricsInspectorElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : 'initialization' }
BlMetricsInspectorElement >> defaultSpacing [
	^ (BlInsets top: 6 right: 8 bottom: 6 left: 8)
]

{ #category : 'initialization' }
BlMetricsInspectorElement >> initialize [
	super initialize.
		
	labelElement := self newLabelElement.
	labelElement constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignTop ].
	
	topInsetElement := self newInsetElement.
	topInsetElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignTop ].

	rightInsetElement := self newInsetElement.
	rightInsetElement constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	
	bottomInsetElement := self newInsetElement.
	bottomInsetElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].
	
	leftInsetElement := self newInsetElement.
	leftInsetElement constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].

	self spacing: self defaultSpacing.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	
	self addChildren: { 
		labelElement.
		topInsetElement.
		rightInsetElement.
		bottomInsetElement.
		leftInsetElement }
]

{ #category : 'instance creation' }
BlMetricsInspectorElement >> insetTextFor: aNumber [

	^ aNumber isZero
		ifTrue: [ BlRopedText string: '-' ]
		ifFalse: [ BlRopedText string: aNumber asString ]
]

{ #category : 'accessing' }
BlMetricsInspectorElement >> insets: anInsets [

	topInsetElement text: (self insetTextFor: anInsets top).
	rightInsetElement text: (self insetTextFor: anInsets right).
	bottomInsetElement text: (self insetTextFor: anInsets bottom).
	leftInsetElement text: (self insetTextFor: anInsets left).
]

{ #category : 'accessing' }
BlMetricsInspectorElement >> label: aString [

	labelElement text: (self labelTextFor: aString).
]

{ #category : 'instance creation' }
BlMetricsInspectorElement >> labelTextFor: aName [

	^ BlRopedText string: aName asString
]

{ #category : 'instance creation' }
BlMetricsInspectorElement >> newInsetElement [
	^ BlTextElement new
		text: (self insetTextFor: 0);
		yourself
]

{ #category : 'instance creation' }
BlMetricsInspectorElement >> newLabelElement [
	^ BlTextElement new
		text: (self labelTextFor: '');
		yourself
]

{ #category : 'layout' }
BlMetricsInspectorElement >> onMeasure: anExtentMeasurementSpec [
	| myExtent |
	super onMeasure: anExtentMeasurementSpec.
	
	myExtent := contentElement measuredExtent.

	"include top label"
	myExtent := myExtent + (0@ topInsetElement measuredHeight).
	"include right label"
	myExtent := myExtent + (rightInsetElement measuredWidth @ 0).
	"include bottom label"
	myExtent := myExtent + (0@ bottomInsetElement measuredHeight).
	"include left label"
	myExtent := myExtent + (leftInsetElement measuredWidth @ 0).
	
	"include name label"
	myExtent := myExtent max: ((topInsetElement measuredWidth @ 0) + (labelElement measuredWidth * 2 @ 0)).

	self measuredExtent: myExtent.
]

{ #category : 'accessing' }
BlMetricsInspectorElement >> spacing [
	^ spacing
]

{ #category : 'accessing' }
BlMetricsInspectorElement >> spacing: aBlInsets [
	spacing := aBlInsets.
	
	labelElement padding: (BlInsets
		top: aBlInsets top
		right: aBlInsets top * 2
		bottom: aBlInsets bottom
		left: aBlInsets top * 2).
	
	topInsetElement padding: (BlInsets
		top: aBlInsets top
		right: 2
		bottom: aBlInsets bottom
		left: 2).

	rightInsetElement padding: (BlInsets
		top: 1
		right: aBlInsets right
		bottom: 1
		left: aBlInsets left).

	bottomInsetElement padding: (BlInsets
		top: aBlInsets top
		right: 2
		bottom: aBlInsets bottom
		left: 2).
		
	leftInsetElement padding: (BlInsets
		top: 1
		right: aBlInsets right
		bottom: 1
		left: aBlInsets left).
]
