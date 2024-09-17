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
	span:		<BlGridLayoutInterval>
	startDefined:		<Boolean>
	weight:		<Number>

"
Class {
	#name : #BlGridLayoutSpec,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'startDefined',
		'span',
		'alignment',
		'weight'
	],
	#classVars : [
		'DefaultWeight'
	],
	#pools : [
		'BlGridLayoutConstants'
	],
	#classInstVars : [
		'undefined'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #cleanup }
BlGridLayoutSpec class >> cleanUp [
	super cleanUp.
	
	undefined := nil
]

{ #category : #'class initialization' }
BlGridLayoutSpec class >> initialize [
	DefaultWeight := 0
]

{ #category : #'instance creation' }
BlGridLayoutSpec class >> new [
	self error: 'Use one of the factory methods instead'
]

{ #category : #'instance creation' }
BlGridLayoutSpec class >> start: aStart [
	<return: #BlGridLayoutSpec>

	^ self
		start: aStart
		size: 1
]

{ #category : #'instance creation' }
BlGridLayoutSpec class >> start: aStart size: aSize [
	<return: #BlGridLayoutSpec>

	^ self
		start: aStart
		size: aSize
		alignment: BlGridAlignment undefined
]

{ #category : #'instance creation' }
BlGridLayoutSpec class >> start: aStart size: aSize alignment: anAlignment [
	<return: #BlGridLayoutSpec>

	^ self
		start: aStart
		size: aSize
		alignment: anAlignment
		weight: DefaultWeight
]

{ #category : #'instance creation' }
BlGridLayoutSpec class >> start: aStart size: aSize alignment: anAlignment weight: aWeight [

	^ self basicNew
		  setAlignment: anAlignment
		  span: (BlGridLayoutInterval min: aStart max: aStart + aSize)
		  startDefined: aStart ~= UNDEFINED
		  weight: aWeight;
		  yourself
]

{ #category : #accessing }
BlGridLayoutSpec class >> undefined [
	<return: #BlGridLayoutSpec>
	
	^ undefined ifNil: [ undefined := self start: UNDEFINED ]
]

{ #category : #comparing }
BlGridLayoutSpec >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ span = anObject span and: [ alignment = anObject alignment ]
]

{ #category : #private }
BlGridLayoutSpec >> absoluteAlignment: isHorizontal [
	<return: #BlGridAlignment>

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
	<return: #BlGridAlignment>

	^ alignment
]

{ #category : #copying }
BlGridLayoutSpec >> copyWithAlignment: anAlignment [
	<return: #BlGridLayoutSpec>

	^ self class basicNew
		setAlignment: anAlignment
		span: span
		startDefined: startDefined
		weight: weight
]

{ #category : #copying }
BlGridLayoutSpec >> copyWithSpan: newSpan [
	<return: #BlGridLayoutSpec>

	^ self class basicNew
		setAlignment: alignment
		span: newSpan
		startDefined: startDefined
		weight: weight
]

{ #category : #copying }
BlGridLayoutSpec >> copyWithWeight: newWeight [
	<return: #BlGridLayoutSpec>

	^ self class basicNew
		setAlignment: alignment
		span: span
		startDefined: startDefined
		weight: newWeight
]

{ #category : #accessing }
BlGridLayoutSpec >> flexibility [
	<return: #BlGridFlexibility>

	^ (self alignment = BlGridAlignment undefined or: [ self hasWeight ])
		ifTrue: [ BlGridLayoutBounds inflexible ]
		ifFalse: [ BlGridLayoutBounds canStretch ]
]

{ #category : #testing }
BlGridLayoutSpec >> hasWeight [

	^ (self weight closeTo: 0.0) not
]

{ #category : #comparing }
BlGridLayoutSpec >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ span hash bitXor: alignment hash
]

{ #category : #initialization }
BlGridLayoutSpec >> setAlignment: anAlignment span: aBlGridLayoutInterval startDefined: isStartDefined weight: aWeight [

	alignment := anAlignment.
	span := aBlGridLayoutInterval.
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
