"
I represent a local element's transformation defined by a composition of affine transformations.

Transformation matrix is computed lazily up-on request for #matrix.

"
Class {
	#name : #BlElementLocalTransformation,
	#superclass : #BlElementDynamicTransformation,
	#instVars : [
		'affineTransformation'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlElementLocalTransformation class >> new [

	^ self newWith: BlAffineCompositeTransformation new
]

{ #category : #'instance creation' }
BlElementLocalTransformation class >> newWith: aBlAffineTransformation [

	^ self basicNew
		  initializeWith: aBlAffineTransformation;
		  yourself
]

{ #category : #accessing }
BlElementLocalTransformation >> affineTransformation [

	^ affineTransformation
]

{ #category : #enumerating }
BlElementLocalTransformation >> affineTransformationsDo: aBlockClosure [ 

	affineTransformation do: aBlockClosure
]

{ #category : #computation }
BlElementLocalTransformation >> computeMatrix: aBlMatrix in: aRectangle [

	affineTransformation multiplyOn: aBlMatrix in: aRectangle
]

{ #category : #initialization }
BlElementLocalTransformation >> initializeWith: aBlAffineTransformation [

	self initialize.
	affineTransformation := aBlAffineTransformation
]

{ #category : #testing }
BlElementLocalTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"

	^ affineTransformation is2D
]

{ #category : #testing }
BlElementLocalTransformation >> is3D [
	"Return true if my current transformation is in 3D space, false otherwise"

	^ affineTransformation is3D
]

{ #category : #testing }
BlElementLocalTransformation >> isIdentity [

	"Return true if I represent an identity transformation, false otherwise"

	^ affineTransformation isIdentity
]

{ #category : #testing }
BlElementLocalTransformation >> isPureTranslation [
	"Return true if I represent an pure translation, false otherwise"

	^ affineTransformation isTranslation
]

{ #category : #copying }
BlElementLocalTransformation >> postCopy [

	super postCopy.
	affineTransformation := affineTransformation copy
]
