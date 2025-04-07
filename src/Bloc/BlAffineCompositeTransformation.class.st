"
I composite `BlAffineTransformation` objects.

There can be only one transformation instance per type.
"
Class {
	#name : #BlAffineCompositeTransformation,
	#superclass : #BlAffineTransformation,
	#instVars : [
		'transformations'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #comparing }
BlAffineCompositeTransformation >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self transformations = anObject transformations
]

{ #category : #adding }
BlAffineCompositeTransformation >> addTransformation: aBlAffineTransformation [
	"There can be only one transformation instance per type"

	transformations add: aBlAffineTransformation
]

{ #category : #enumerating }
BlAffineCompositeTransformation >> do: aBlock [

	transformations do: [ :each | each do: aBlock ]
]

{ #category : #testing }
BlAffineCompositeTransformation >> hasTransformations [

	^ transformations isNotEmpty
]

{ #category : #initialization }
BlAffineCompositeTransformation >> initialize [

	super initialize.

	transformations := OrderedCollection new
]

{ #category : #testing }
BlAffineCompositeTransformation >> is2D [

	^ transformations allSatisfy: [ :each | each is2D ]
]

{ #category : #testing }
BlAffineCompositeTransformation >> isIdentity [

	^ self hasTransformations not
]

{ #category : #testing }
BlAffineCompositeTransformation >> isTranslation [

	^ transformations allSatisfy: [ :each | each isTranslation ]
]

{ #category : #testing }
BlAffineCompositeTransformation >> multiplyOn: aBlMatrix [

	transformations do: [ :each | 
		each multiplyOn: aBlMatrix ]
]

{ #category : #testing }
BlAffineCompositeTransformation >> multiplyOn: aBlMatrix in: aBlElement [

	transformations do: [ :each | 
		each multiplyOn: aBlMatrix in: aBlElement ]
]

{ #category : #printing }
BlAffineCompositeTransformation >> printOn: aStream [

	aStream nextPutAll: 'Composition'
]

{ #category : #accessing }
BlAffineCompositeTransformation >> transformations [
	
	^ transformations
]
