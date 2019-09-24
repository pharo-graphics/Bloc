Class {
	#name : #BlVectorShape,
	#superclass : #Object,
	#instVars : [
		'parent',
		'attributes'
	],
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #converting }
BlVectorShape >> asElementIn: aContainer [
	self subclassResponsibility
]

{ #category : #accessing }
BlVectorShape >> attributeAt: aName ifAbsentPut: aValue [
	^ self attributes at: aName ifAbsentPut: aValue
]

{ #category : #accessing }
BlVectorShape >> attributeAt: aName put: aValue [
	self attributes at: aName put: aValue
]

{ #category : #accessing }
BlVectorShape >> attributes [
	^ attributes
]

{ #category : #ui }
BlVectorShape >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [
			| aContainer |
			
			aContainer := BlVectorShapeContainerElement new.
			aContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
			self asElementIn: aContainer.
			aContainer ]
]

{ #category : #testing }
BlVectorShape >> hasParent [
	^ parent isNotNil
]

{ #category : #initialization }
BlVectorShape >> initialize [
	super initialize.
	
	attributes := Dictionary new
]

{ #category : #accessing }
BlVectorShape >> parent [
	<return: #BlCompositeShape>

	^ parent
]

{ #category : #accessing }
BlVectorShape >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
BlVectorShape >> parentDo: aBlock [
	self hasParent
		ifTrue: [ aBlock value: self parent ]
]

{ #category : #enumerating }
BlVectorShape >> shapesDo: aBlock [
	aBlock value: self
]
