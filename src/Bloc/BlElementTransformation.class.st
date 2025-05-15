"
I represent an element transformation and support both 2D and 3D transformations.

For optimization purposes I use 2D matrix if 3D transformation was not requested. As soon as I'm transformed in 3D all further transformation will also happen with the help of 3D matrix.

"
Class {
	#name : #BlElementTransformation,
	#superclass : #Object,
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlElementTransformation class >> scale: aBlVector [

	| aScaleTransformation |
	
	aScaleTransformation := BlScalingTransformation new
		origin: BlAffineTransformationCenterOrigin defaultInstance;
		scale: aBlVector;
		yourself.
	
	^ BlElementLocalTransformation newWith: aScaleTransformation
]

{ #category : #enumerating }
BlElementTransformation >> affineTransformationsDo: aBlockClosure [
	"Evaluate the block with associated instances of `BlAffineTransformation`."

	self subclassResponsibility
]

{ #category : #converting }
BlElementTransformation >> asCachedTransformationIn: aRectangle [

	^ BlElementCachedExplicitTransformation
		  forTransformation: self
		  in: aRectangle
]

{ #category : #converting }
BlElementTransformation >> asElementTransformation [

	^ self
]

{ #category : #converting }
BlElementTransformation >> asMatrix: aRectangle [

	| aMatrix |
	aMatrix := self is2D
		ifTrue: [ BlMatrix2D new ]
		ifFalse: [ BlMatrix3D new ].
	
	self computeMatrix: aMatrix in: aRectangle.

	^ aMatrix
]

{ #category : #computation }
BlElementTransformation >> computeMatrix: aBlMatrix in: aRectangle [

	self subclassResponsibility
]

{ #category : #testing }
BlElementTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlElementTransformation >> is3D [
	"Return true if my current transformation is in 3D space, false otherwise"

	^ self subclassResponsibility
]

{ #category : #testing }
BlElementTransformation >> isIdentity [
	"Return true if I represent the identity transformation, false otherwise"
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlElementTransformation >> isPureTranslation [
	"Return true if the receiver specifies no rotation or scaling and represents only translation in xy 2D plane"
	
	^ self subclassResponsibility
]
