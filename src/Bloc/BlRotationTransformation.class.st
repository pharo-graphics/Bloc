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

{ #category : #accessing }
BlRotationTransformation >> angle [
	^ angle
]

{ #category : #accessing }
BlRotationTransformation >> angle: aNumber [
	"Set a rotation angle in degrees"

	angle := aNumber
]

{ #category : #converting }
BlRotationTransformation >> asQuaternion [
	<return: #BlQuaternion>

	^ BlQuaternion x: self axis x y: self axis y z: self axis z angle: self angle
]

{ #category : #accessing }
BlRotationTransformation >> axis [
	<return: #BlVector>
	
	^ axis
]

{ #category : #accessing }
BlRotationTransformation >> axis: aVector [
	axis := aVector
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
	<return: #Boolean>

	^ self axis = BlVector zAxis
]

{ #category : #'mathematical functions' }
BlRotationTransformation >> multiplyOn: aBlMatrix [

	aBlMatrix
		rotateByDegrees: self angle
		around: self axis
]

{ #category : #printing }
BlRotationTransformation >> printOn: aStream [
	aStream
		nextPutAll: 'Rotation by ';
		nextPutAll: self angle asString;
		nextPutAll: ' degress around axis ';
		nextPutAll: self axis asString
]
