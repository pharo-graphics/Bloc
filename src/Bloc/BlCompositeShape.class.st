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

	aNewShape attributes addAll: anOldShape attributes.

	anOldShape parent: nil.
	aNewShape parent: self.

	shapes replaceAll: anOldShape with: aNewShape
]

{ #category : #'api - shapes' }
BlCompositeShape >> shapeWithAttribute: aName detectValue: aValue [
	^ self shapes detect: [ :each | (each attributes at: aName) detect: [ :eachValue | eachValue = aValue ] ifFound: [ true ] ]
]

{ #category : #'api - shapes' }
BlCompositeShape >> shapeWithAttribute: aName includesValue: aValue [
	^ self shapes detect: [ :each | (each attributes at: aName) includes: aValue ]
]

{ #category : #'api - shapes' }
BlCompositeShape >> shapeWithAttribute: aName value: aValue [
	^ self shapes detect: [ :each | (each attributes at: aName) = aValue ]
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
