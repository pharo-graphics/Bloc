Class {
	#name : #BlShearTransformation,
	#superclass : #BlAffineTransformation,
	#instVars : [
		'coefficient'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #comparing }
BlShearTransformation >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self coefficient = anObject coefficient
]

{ #category : #accessing }
BlShearTransformation >> angleX: anAngleInDegrees [

	self coefficient:
		anAngleInDegrees degreesToRadians tan negated @ self coefficient y
]

{ #category : #accessing }
BlShearTransformation >> angleY: anAngleInDegrees [

	self coefficient:
		self coefficient x @ anAngleInDegrees degreesToRadians tan negated
]

{ #category : #accessing }
BlShearTransformation >> coefficient [

	^ coefficient
]

{ #category : #accessing }
BlShearTransformation >> coefficient: aPoint [

	coefficient := aPoint
]

{ #category : #initialization }
BlShearTransformation >> initialize [
	super initialize.
	
	coefficient := 0.0@0.0
]

{ #category : #testing }
BlShearTransformation >> is2D [
	"Return true if transformation happens in x-y plane, hence 2D"
	
	^ true
]

{ #category : #'mathematical functions' }
BlShearTransformation >> multiplyOn: aBlMatrix [

	aBlMatrix multiplyBy: (BlMatrix2D shear: coefficient)
]

{ #category : #printing }
BlShearTransformation >> printOn: aStream [

	aStream
		nextPutAll: 'Shear by ';
		nextPutAll: coefficient asString
]
