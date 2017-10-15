instance creation
x: aX y: aY z: aZ angle: aTheta
	"Create a quaternion representing a rotation about axis defined by a vector (x,y,z) by angle aTheta in radians"
	<return: #BlQuaternion>
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