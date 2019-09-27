Class {
	#name : #BlAffineCompositeTransformation,
	#superclass : #BlAffineTransformation,
	#instVars : [
		'transformations'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #adding }
BlAffineCompositeTransformation >> addTransformation: aBlAffineTransformation [
	"There can be only one transformation instance per type"

	self transformations add: aBlAffineTransformation
]

{ #category : #enumerating }
BlAffineCompositeTransformation >> do: aBlock [
	transformations do: [ :aTransfromation | aTransfromation do: aBlock ]
]

{ #category : #testing }
BlAffineCompositeTransformation >> hasTransformations [
	<return: #Boolean>

	^ self transformations isNotEmpty
]

{ #category : #initialization }
BlAffineCompositeTransformation >> initialize [
	super initialize.
	
	transformations := OrderedCollection new
]

{ #category : #testing }
BlAffineCompositeTransformation >> is2D [
	^ self transformations allSatisfy: #is2D
]

{ #category : #testing }
BlAffineCompositeTransformation >> isIdentity [
	^ self hasTransformations not
]

{ #category : #testing }
BlAffineCompositeTransformation >> multiplyOn: aBlMatrix [
	self transformations do: [ :aTransformation | aTransformation multiplyOn: aBlMatrix ]
]

{ #category : #testing }
BlAffineCompositeTransformation >> multiplyOn: aBlMatrix in: aBlElement [
	self transformations do: [ :aTransformation | aTransformation multiplyOn: aBlMatrix in: aBlElement ]
]

{ #category : #printing }
BlAffineCompositeTransformation >> printOn: aStream [
	aStream nextPutAll: 'Composition'
]

{ #category : #accessing }
BlAffineCompositeTransformation >> transformations [
	<return: #Collection of: #BlAffineTransformation>
	
	^ transformations
]
