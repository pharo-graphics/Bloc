"
Specifies a rotation by the angle specified in the parameter about the origin of the element, as defined by the transformation #origin property. For example, rotate(90deg) would cause elements to appear rotated one-quarter of a turn in the clockwise direction.

Corresponds to SVG rotate() function
https://drafts.csswg.org/css-transforms/#valdef-transform-rotate

"
Class {
	#name : #BlRotationTransformation,
	#superclass : #BlAffineTransformation,
	#instVars : [
		'angle',
		'axis'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #comparing }
BlRotationTransformation >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self angle = anObject angle and: [ self axis = anObject axis ]
]

{ #category : #accessing }
BlRotationTransformation >> angle [

	^ angle
]

{ #category : #accessing }
BlRotationTransformation >> angle: aNumberOfDegrees [
	"Set a rotation angle in degrees (not radians)"

	angle := aNumberOfDegrees
]

{ #category : #converting }
BlRotationTransformation >> asQuaternion [

	^ BlQuaternion x: self axis x y: self axis y z: self axis z angle: self angle
]

{ #category : #accessing }
BlRotationTransformation >> axis [
	
	^ axis
]

{ #category : #accessing }
BlRotationTransformation >> axis: aBlVector [

	axis := aBlVector
]

{ #category : #initialization }
BlRotationTransformation >> initialize [
	super initialize.
	
	angle := 0. "degrees"
	axis := BlVector zAxis
]

{ #category : #testing }
BlRotationTransformation >> is2D [
	"Return true if I represent a rotation in 2D space, false otherwise.
	By definition a rotation is in 2D when rotation axis is z-Axis (it has no x or y components)"

	^ axis = BlVector zAxis
]

{ #category : #'mathematical functions' }
BlRotationTransformation >> multiplyOn: aBlMatrix [

	aBlMatrix
		rotateByDegrees: angle
		around: axis
]

{ #category : #printing }
BlRotationTransformation >> printOn: aStream [

	aStream
		nextPutAll: 'Rotation by ';
		nextPutAll: angle asString;
		nextPutAll: ' degrees around axis ';
		nextPutAll: axis asString
]
