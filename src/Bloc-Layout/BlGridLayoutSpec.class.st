"
I define characteristics of a group of cells on the grid (indices, weight and alignment) along corresponding axis.

I am supposed to be immutable. In order to create a new spec with different parameters use provided copyWith*: methods

Public API and Key Messages

- span, declares indices on the grid. span first is an index of a row or column that cell wants to occupy.
- weight, proportional weight allowing to distribute cells proportionally. In order to work all cells in a group must have weight > 0.
- alignment, specifies how cells should be aligned within row or column groups.
- flexibility, dynamically determined based on current alignment and weight
- startDefined, true if span first is undefined. Means that it is up to grid to determine indices

	BlGridLayoutSpec new
		setAlignment: BlGridAlignment fill
		span:  (1 to: 2)
		startDefined:  true
		weight: 1
 
Internal Representation and Key Implementation Points.

    Instance Variables
	alignment:		<BlGridAlignment>
	span:		<Interval>
	startDefined:		<Boolean>
	weight:		<Number>
"
Class {
	#name : #BlGridLayoutSpec,
	#superclass : #Object,
	#instVars : [
		'startDefined',
		'span',
		'alignment',
		'weight'
	],
	#pools : [
		'BlGridLayoutConstants'
	],
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #private }
BlGridLayoutSpec >> absoluteAlignment: isHorizontal [
	(self alignment = BlGridAlignment undefined)
		ifFalse: [ ^ self alignment ].
	
	self hasWeight
		ifFalse: [ ^ isHorizontal
			ifTrue: [ BlGridAlignment start ]
			ifFalse: [ BlGridAlignment baseline ] ].
		
	^ BlGridAlignment fill
]

{ #category : #accessing }
BlGridLayoutSpec >> alignment [
	^ alignment
]

{ #category : #copying }
BlGridLayoutSpec >> copyWithAlignment: anAlignment [
	^ self class new
		setAlignment: anAlignment
		span: span
		startDefined: startDefined
		weight: weight
]

{ #category : #copying }
BlGridLayoutSpec >> copyWithSpan: newSpan [
	^ self class new
		setAlignment: alignment
		span: newSpan
		startDefined: startDefined
		weight: weight
]

{ #category : #copying }
BlGridLayoutSpec >> copyWithWeight: newWeight [
	^ self class new
		setAlignment: alignment
		span: span
		startDefined: startDefined
		weight: newWeight
]

{ #category : #accessing }
BlGridLayoutSpec >> flexibility [
	^ (self alignment = BlGridAlignment undefined or: [ self hasWeight ])
		ifTrue: [ BlGridLayoutBounds inflexible ]
		ifFalse: [ BlGridLayoutBounds canStretch ]
]

{ #category : #testing }
BlGridLayoutSpec >> hasWeight [
	^ self weight ~= 0.0
]

{ #category : #initialization }
BlGridLayoutSpec >> initialize [
	super initialize.
	
	startDefined := false.
	span := Interval from: UNDEFINED to: UNDEFINED + 1. 
	weight := 0.
	alignment := BlGridAlignment undefined
]

{ #category : #private }
BlGridLayoutSpec >> setAlignment: anAlignment span: aSpan startDefined: isStartDefined weight: aWeight [
	alignment := anAlignment.
	span := aSpan.
	startDefined := isStartDefined.
	weight := aWeight
]

{ #category : #accessing }
BlGridLayoutSpec >> span [
	<return: #Interval>
	^ span
]

{ #category : #accessing }
BlGridLayoutSpec >> startDefined [
	^ startDefined
]

{ #category : #accessing }
BlGridLayoutSpec >> weight [
	^ weight
]
