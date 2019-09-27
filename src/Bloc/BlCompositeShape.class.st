Class {
	#name : #BlCompositeShape,
	#superclass : #BlVectorShape,
	#instVars : [
		'shapes'
	],
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'api - shapes' }
BlCompositeShape >> addShape: aShape [
	aShape parent: self.
	shapes add: aShape
]

{ #category : #converting }
BlCompositeShape >> asElementIn: aContainer [
	self shapes do: [ :each | each asElementIn: aContainer ]
]

{ #category : #initialization }
BlCompositeShape >> initialize [
	super initialize.
	
	shapes := OrderedCollection new
]

{ #category : #'api - shapes' }
BlCompositeShape >> replaceShape: anOldShape with: aNewShape [
	
	(shapes includes: anOldShape)
		ifFalse: [ ^ self error: 'No such shape to replace' ].

	aNewShape attributes addAll: anOldShape attributes.

	anOldShape parent: nil.
	aNewShape parent: self.

	shapes replaceAll: anOldShape with: aNewShape
]

{ #category : #'api - shapes' }
BlCompositeShape >> shapeWithAttribute: aName includesValue: aValue [
	^ self allShapes detect: [ :each | each attributes
		at: aName
		ifPresent: [ :eachValue | eachValue includes: aValue ]
		ifAbsent: [ false ] ]
]

{ #category : #'api - shapes' }
BlCompositeShape >> shapeWithAttribute: aName value: aValue [
	^ self allShapes detect: [ :each | each attributes
		at: aName
		ifPresent: [ :eachValue | eachValue = aValue ]
		ifAbsent: [ false ] ]
]

{ #category : #accessing }
BlCompositeShape >> shapes [
	^ shapes
]

{ #category : #accessing }
BlCompositeShape >> shapes: aCollectionOfShapes [
	shapes := aCollectionOfShapes asOrderedCollection.
	shapes do: [ :each | each parent: self ]
]

{ #category : #'api - shapes' }
BlCompositeShape >> shapesDo: aBlock [
	aBlock value: self.
	self shapes do: [ :each | each shapesDo: aBlock ]
]
