"
Unit quaternions, also known as versors, provide a convenient mathematical notation for representing orientations and rotations of objects in three dimensions. Compared to Euler angles they are simpler to compose and avoid the problem of gimbal lock. Compared to rotation matrices they are more compact, more numerically stable, and may be more efficient. Quaternions have applications in computer graphics, computer vision, robotics, navigation, molecular dynamics, flight dynamics,[1] orbital mechanics of satellites[2] and crystallographic texture analysis.[3]
When used to represent rotation, unit quaternions are also called rotation quaternions. When used to represent an orientation (rotation relative to a reference coordinate system), they are called orientation quaternions or attitude quaternions.

https://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation#Using_quaternion_rotations

"
Class {
	#name : #BlQuaternion,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z',
		'w'
	],
	#category : #'Bloc-Basic-Math'
}

{ #category : #'instance creation' }
BlQuaternion class >> x: aX y: aY z: aZ angle: aTheta [
	"Create a quaternion representing a rotation about axis defined by a vector (x,y,z) by angle aTheta in radians"

	"length - length of a vector (aX, aY, aZ)
	x,y,z - components of a normalized vector Normalized(aX,aY,aZ)"
	| length x y z w cosTheta sinTheta sc sq m11 m12 m13 m21 m22 m23 m31 m32 m33 trace |
	
	length := ((aX * aX) + (aY * aY) + (aZ * aZ)) sqrt.

	length isZero
		ifTrue: [ ^ self error: 'Can not rotate about a zero vector!' ].
	
	"normalization"
	x := aX / length.
	y := aY / length.
	z := aZ / length.
	
	cosTheta := aTheta cos.
	(cosTheta closeTo: 0.0) ifTrue: [ cosTheta := 0.0 ].
	
	sinTheta := aTheta sin.
	(sinTheta closeTo: 0.0) ifTrue: [ sinTheta := 0.0 ].
	
	"sin(aTheta / 2) * cos(aTheta / 2)"
	sc := sinTheta  / 2.0.
	
	"sin(aTheta / 2)^2"
	sq := (1.0 - cosTheta) / 2.0.
	
	"computing rotation matrix components
	https://www.w3.org/TR/css3-3d-transforms/#Rotate3dDefined"
	m11 := 1 - (2 * ((y * y) + (z * z)) * sq).
	m12 := 2 * ((x * y * sq) + (z * sc)).
	m13 := 2 * ((x * z * sq) - (y * sc)).
	
	m21 := 2 * ((x * y * sq) - (z * sc)).
	m22 := 1 - (2 * ((x * x) + (z * z)) * sq).
	m23 := 2 * ((y * z * sq) + (x * sc)).
	
	m31 := 2 * ((x * z * sq) + (y * sc)).
	m32 := 2 * ((y * z * sq) - (x * sc)).
	m33 := 1 - (2 * ((x * x) + (y * y)) * sq).
	
	"computing quaternion components out of rotation matrix
	http://www.euclideanspace.com/maths/geometry/rotations/conversions/matrixToQuaternion/index.htm"
	trace := m11 + m22 + m33.
	
	(trace > 0.0)
		ifTrue: [ | s |
			s := 0.5 / (trace + 1.0) sqrt.
			x := (m32 - m23) * s.
			y := (m13 - m31) * s.
			z := (m21 - m12) * s.
			w := 0.25 / s ]
		ifFalse: [
			(m11 > m22 and: [ m11 > m33 ])
				ifTrue: [ | s |
					s := 2.0 * (1.0 + m11 - m22 - m33) sqrt.
					x := 0.25 * s.
					y := (m12 + m21) / s.
					z := (m13 + m31) / s.
					w := (m32 - m23) / s ]
				ifFalse: [
					(m22 > m33)
						ifTrue: [ | s |
							s := 2.0 * (1.0 + m22 - m11 - m33) sqrt.
							x := (m12 + m21) / s.
							y := 0.25 * s.
							z := (m23 + m32) / s.
							w := (m13 - m31) / s ]
						ifFalse: [ | s |
							s := 2.0 * (1.0 + m33 - m11 - m22) sqrt.
							x := (m13 + m32) / s.
							y := (m23 + m32) / s.
							z := 0.25 * s.
							w := (m21 - m12) / s ] ] ].
	
	^ self x: x y: y z: z w: w
]

{ #category : #'instance creation' }
BlQuaternion class >> x: aX y: aY z: aZ w: aW [

	^ self new
		  x: aX
		  y: aY
		  z: aZ
		  w: aW;
		  yourself
]

{ #category : #arithmetic }
BlQuaternion >> * aQuaternion [
	"Multiply me by a given quaternion and return a new instance representing a multiplication result"

	| rX rY rZ rW |	"components of a resulting quaternion"

	rX := (x * aQuaternion w) + (w * aQuaternion x) + (y * aQuaternion z) - (z * aQuaternion y).
	rY := (y * aQuaternion w) + (w * aQuaternion y) + (z * aQuaternion x) - (x * aQuaternion z).
	rZ := (z * aQuaternion w) + (w * aQuaternion z) + (x * aQuaternion y) - (y * aQuaternion x).
	rW := (w * aQuaternion w) - (x * aQuaternion x) + (y * aQuaternion y) - (z * aQuaternion z).

	^ self class x: rX y: rY z: rZ w: rW
]

{ #category : #initialization }
BlQuaternion >> initialize [

	super initialize.

	x := 0.0.
	y := 0.0.
	z := 0.0.
	w := 1.0
]

{ #category : #accessing }
BlQuaternion >> length [
	"Return euclidian norm (length) of this quaternion"

	^ ((x * x) + (y * y) + (z * z) + (w * w)) sqrt
]

{ #category : #converting }
BlQuaternion >> normalize [
	"Normalize me in-place"

	| length |
	length := self length.
	
	"length is 1, no need to normalize"
	(length closeTo: 1.0) ifTrue: [ ^ self ].
	
	length isZero
		ifTrue: [ self x: 0.0 y: 0.0 z: 0.0 w: 1.0 ]
		ifFalse: [ self x: x / length y: y / length z: z / length w: w / length ]
]

{ #category : #converting }
BlQuaternion >> normalized [
	"Return a new instance of me being normalized"

	^ self copy
		  normalize;
		  yourself
]

{ #category : #printing }
BlQuaternion >> printOn: aStream [

	aStream
		nextPut: $(;
		nextPutAll: self x asString;
		nextPutAll: ', ';
		nextPutAll: self y asString;
		nextPutAll: ', ';
		nextPutAll: self z asString;
		nextPutAll: ', ';
		nextPutAll: self w asString;
		nextPut: $)
]

{ #category : #accessing }
BlQuaternion >> w [

	^ w
]

{ #category : #accessing }
BlQuaternion >> x [

	^ x
]

{ #category : #initialization }
BlQuaternion >> x: aX y: aY z: aZ w: aW [

	x := aX.
	y := aY.
	z := aZ.
	w := aW
]

{ #category : #accessing }
BlQuaternion >> y [

	^ y
]

{ #category : #accessing }
BlQuaternion >> z [

	^ z
]
