"
In geometry, an affine transformation, affine map or an affinity (from the Latin, affinis, ""connected with"") is a function between affine spaces which preserves points, straight lines and planes. Also, sets of parallel lines remain parallel after an affine transformation. An affine transformation does not necessarily preserve angles between lines or distances between points, though it does preserve ratios of distances between points lying on a straight line.
Examples of affine transformations include translation, scaling, homothety, similarity transformation, reflection, rotation, shear mapping, and compositions of them in any combination and sequence.

https://en.wikipedia.org/wiki/Affine_transformation

"
Class {
	#name : #BlAffineTransformation,
	#superclass : #Object,
	#instVars : [
		'origin'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : #converting }
BlAffineTransformation >> asMatrix [

	| aMatrix |
	
	aMatrix := self is2D
		ifTrue: [ BlMatrix2D new ]
		ifFalse: [ BlMatrix3D new ].
		
	self multiplyOn: aMatrix.

	^ aMatrix
]

{ #category : #enumerating }
BlAffineTransformation >> do: aBlock [

	aBlock value: self
]

{ #category : #initialization }
BlAffineTransformation >> initialize [

	super initialize.
	
	origin := BlAffineTransformationCenterOrigin defaultInstance
]

{ #category : #testing }
BlAffineTransformation >> is2D [
	"Return true if transformation happens in x-y plane, hence 2D"
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlAffineTransformation >> is3D [
	"Return true if transformation happens in x-y-z plane, hence 3D"
	
	^ self is2D not
]

{ #category : #testing }
BlAffineTransformation >> isIdentity [
	"Return true if thiss transformation is identity"
	
	^ false
]

{ #category : #testing }
BlAffineTransformation >> isTranslation [
	"Return true if this transformation is translation"
	
	^ false
]

{ #category : #'mathematical functions' }
BlAffineTransformation >> multiplyOn: aBlMatrix [

	self subclassResponsibility
]

{ #category : #'mathematical functions' }
BlAffineTransformation >> multiplyOn: aBlMatrix in: aBlElement [

	| aBlVector |
	aBlVector := (self origin originIn: aBlElement) asBlocVector.
	
	aBlMatrix translateBy: aBlVector negated.
	self multiplyOn: aBlMatrix.
	aBlMatrix translateBy: aBlVector
]

{ #category : #accessing }
BlAffineTransformation >> origin [

	^ origin
]

{ #category : #accessing }
BlAffineTransformation >> origin: aBlAffineTransformationOrigin [

	origin := aBlAffineTransformationOrigin
]
