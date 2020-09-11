"
I represent a local element's transformation defined by a composition of affine transformations.

Transformation matrix is computed lazily up-on request for #matrix.
"
Class {
	#name : #BlElementLocalTransformation,
	#superclass : #BlElementDynamicTransformation,
	#instVars : [
		'transformation'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlElementLocalTransformation class >> with: anAfineTransformation [
	^ self basicNew
		initializeWith: anAfineTransformation
]

{ #category : #computation }
BlElementLocalTransformation >> computeMatrix: aBlMatrix in: aRectangle [
	transformation multiplyOn: aBlMatrix in: aRectangle
]

{ #category : #initialization }
BlElementLocalTransformation >> initialize [
	super initialize.
	
	transformation := BlAffineCompositeTransformation new
]

{ #category : #initialization }
BlElementLocalTransformation >> initializeWith: aTransformation [
	super initialize.

	transformation := aTransformation
]

{ #category : #testing }
BlElementLocalTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"
	<return: #Boolean>

	^ self transformation is2D
]

{ #category : #testing }
BlElementLocalTransformation >> is3D [
	"Return true if my current transformation is in 3D space, false otherwise"
	<return: #Boolean>

	^ self transformation is3D
]

{ #category : #testing }
BlElementLocalTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>
	
	^ self transformation isIdentity
]

{ #category : #testing }
BlElementLocalTransformation >> isPureTranslation [
	"Return true if I represent an pure translation, false otherwise"
	<return: #Boolean>
	
	^ self transformation isTranslation
]

{ #category : #copying }
BlElementLocalTransformation >> postCopy [
	super postCopy.

	transformation := transformation copy
]

{ #category : #accessing }
BlElementLocalTransformation >> transformation [
	<return: #BlAffineCompositeTransformation>

	^ transformation
]
