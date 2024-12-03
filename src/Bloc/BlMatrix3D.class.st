"
I represent a matrix used for 3D affine transformations.
https://en.wikipedia.org/wiki/Transformation_matrix#Examples_in_3D_computer_graphics

My components are named according to mathematical convention:

 |  a11  a12  a13  a14  |                 |    sx     shy0  shz0   wx  |
 |  a21  a22  a23  a24  |       =>     |  shx0    sy     shz1   wy  |
 |  a31  a32  a33  a34  |                 |  shx1  shy1    sz      wz  |
 |  a41  a42  a43  a44  |                 |     x         y         z        w    |

"
Class {
	#name : #BlMatrix3D,
	#superclass : #BlMatrix,
	#instVars : [
		'sx',
		'shy0',
		'shz0',
		'wx',
		'shx0',
		'sy',
		'shz1',
		'wy',
		'shx1',
		'shy1',
		'sz',
		'wz',
		'x',
		'y',
		'z',
		'w'
	],
	#category : #'Bloc-Basic-Math'
}

{ #category : #'instance creation' }
BlMatrix3D class >> flushToZero: aFloat [

	^ (aFloat closeTo: 0.0)
		  ifTrue: [ 0.0 ]
		  ifFalse: [ aFloat ]
]

{ #category : #'instance creation' }
BlMatrix3D class >> fromQuaternion: aQuaternion [
	"Return a new 3D rotation matrix from a given rotation quaternion"

	^ self new
		  quaternion: aQuaternion;
		  yourself
]

{ #category : #'instance creation' }
BlMatrix3D class >> rotation: aTheta axis: aVector [
	"Create a 3D matrix representing a rotation about a given axis vector
	by aTheta radians"

	^ self new
		  rotation: aTheta axis: aVector;
		  yourself
]

{ #category : #comparing }
BlMatrix3D >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	self sx = anObject sx ifFalse: [ ^ false ].
	self shy0 = anObject shy0 ifFalse: [ ^ false ].
	self shz0 = anObject shz0 ifFalse: [ ^ false ].
	self wx = anObject wx ifFalse: [ ^ false ].
	self shx0 = anObject shx0 ifFalse: [ ^ false ].
	self shz1 = anObject shz1 ifFalse: [ ^ false ].
	self wy = anObject wy ifFalse: [ ^ false ].
	self shx1 = anObject shx1 ifFalse: [ ^ false ].
	self shy1 = anObject shy1 ifFalse: [ ^ false ].
	self sz = anObject sz ifFalse: [ ^ false ].
	self wz = anObject wz ifFalse: [ ^ false ].
	self x = anObject x ifFalse: [ ^ false ].
	self y = anObject y ifFalse: [ ^ false ].
	self z = anObject z ifFalse: [ ^ false ].
	self w = anObject w ifFalse: [ ^ false ].

	^ true
]

{ #category : #initialization }
BlMatrix3D >> initialize [

	super initialize.

	sx := 1.0.
	shy0 := 0.0.
	shz0 := 0.0.
	wx := 0.0.
	shx0 := 0.0.
	sy := 1.0.
	shz1 := 0.0.
	wy := 0.0.
	shx1 := 0.0.
	shy1 := 0.0.
	sz := 1.0.
	wz := 0.0.
	x := 0.0.
	y := 0.0.
	z := 0.0.
	w := 1.0
]

{ #category : #testing }
BlMatrix3D >> is2D [
	"Return true if matrix is 2D, false otherwise"
	
	^ false
]

{ #category : #testing }
BlMatrix3D >> isIdentity [

	"scale"
	(sx = 1.0 and: [
	 sy = 1.0 and: [
	 sz = 1.0 ]]) ifFalse: [ ^ false ].
	
	"translate"
	(x = 0.0 and: [
	 y = 0.0 and: [
	 z = 0.0 ]]) ifFalse: [ ^ false ].
	
	"shear"
	(shx0 = 0.0 and: [
	 shx1 = 0.0 and: [
	 shy0 = 0.0 and: [
	 shy1 = 0.0 and: [
	 shz0 = 0.0 and: [
	 shz1 = 0.0 ]]]]]) ifFalse: [ ^ false ].

	(w  = 1.0 and: [
	 wx = 0.0 and: [
	 wy = 0.0 and: [
	 wz = 0.0 ]]]) ifFalse: [ ^ false ].

	^ true
]

{ #category : #'matrix - transformations' }
BlMatrix3D >> multiplyBy: aMatrix3D [
	"Multiply me in-place by a given 3D Matrix"
	
	| _sx _shx0 _shx1 _x _shy0 _sy _shy1 _y _shz0 _shz1 _sz _z _wx _wy _wz _w |
	
	_sx := (sx * aMatrix3D sx) + (shy0 * aMatrix3D shx0) + (shz0 * aMatrix3D shx1) + (wx * aMatrix3D x).
	_shx0 := (shx0 * aMatrix3D sx) + (sy * aMatrix3D shx0) + (shz1 * aMatrix3D shx1) + (wy * aMatrix3D x).
	_shx1 := (shx1 * aMatrix3D sx) + (shy1 * aMatrix3D shx0) + (sz * aMatrix3D shx1) + (wz * aMatrix3D x).
	_x := (x * aMatrix3D sx) + (y * aMatrix3D shx0) + (z * aMatrix3D shx1) + (w * aMatrix3D x).

	_shy0 := (sx * aMatrix3D shy0) + (shy0 * aMatrix3D sy) + (shz0 * aMatrix3D shy1) + (wx * aMatrix3D y).
	_sy := (shx0 * aMatrix3D shy0) + (sy * aMatrix3D sy) + (shz1 * aMatrix3D shy1) + (wy * aMatrix3D y).
	_shy1 := (shx1 * aMatrix3D shy0) + (shy1 * aMatrix3D sy) + (sz * aMatrix3D shy1) + (wz * aMatrix3D y).
	_y := (x * aMatrix3D shy0) + (y * aMatrix3D sy) + (z * aMatrix3D shy1) + (w * aMatrix3D y).

	_shz0 := (sx * aMatrix3D shz0) + (shy0 * aMatrix3D shz1) + (shz0 * aMatrix3D sz) + (wx * aMatrix3D z).
	_shz1 := (shx0 * aMatrix3D shz0) + (sy * aMatrix3D shz1) + (shz1 * aMatrix3D sz) + (wy * aMatrix3D z).
	_sz := (shx1 * aMatrix3D shz0) + (shy1 * aMatrix3D shz1) + (sz * aMatrix3D sz) + (wz * aMatrix3D z).
	_z := (x * aMatrix3D shz0) + (y * aMatrix3D shz1) + (z * aMatrix3D sz) + (w * aMatrix3D z).

	_wx := (sx * aMatrix3D wx) + (shy0 * aMatrix3D wy) + (shz0 * aMatrix3D wz) + (wx * aMatrix3D w).
	_wy := (shx0 * aMatrix3D wx) + (sy * aMatrix3D wy) + (shz1 * aMatrix3D wz) + (wy * aMatrix3D w).
	_wz := (shx1 * aMatrix3D wx) + (shy1 * aMatrix3D wy) + (sz * aMatrix3D wz) + (wz * aMatrix3D w).
	_w := (x * aMatrix3D wx) + (y * aMatrix3D wy) + (z * aMatrix3D wz) + (w * aMatrix3D w).

	sx := _sx.
	shx0 := _shx0.
	shx1 := _shx1.
	x := _x.
	
	shy0 := _shy0.
	sy := _sy.
	shy1 := _shy1.
	y := _y.

	shz0 := _shz0.
	shz1 := _shz1.
	sz := _sz.
	z := _z.
	
	wx := _wx.
	wy := _wy.
	wz := _wz.
	w := _w
]

{ #category : #'matrix - transformations' }
BlMatrix3D >> perspective: aDepth [
	"Apply perspective by aDepth which should be positive"
	
	self
		assert: [ aDepth > 0 ]
		description: [ 'Perspective must be positive' ].
	
	shx1 := shx1 - (1.0 / aDepth * x).
	shy1 := shy1 - (1.0 / aDepth * y).
	sz := sz - (1.0 / aDepth * z).
	wz := wz - (1.0 / aDepth * w)
]

{ #category : #'matrix - transformations' }
BlMatrix3D >> postScaleX: aX Y: aY Z: aZ [
	"Apply the scale AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be scaled by given scale factor"

	sx := sx * aX.
	shx0 := shx0 * aX.
	shx1 := shx1 * aX.
	x := x * aX.

	shy0 := shy0 * aY.
	sy := sy * aY.
	shy1 := shy1 * aY.
	y := y * aY.

	shz0 := shz0 * aZ.
	shz1 := shz1 * aZ.
	sz := sz * aZ.
	z := z * aZ
]

{ #category : #'matrix - transformations' }
BlMatrix3D >> postTranslateX: aX Y: aY Z: aZ [
	"Apply the translation AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be translated by given translation"

	sx := sx + (wx * aX).
	shx0 := shx0 + (wy * aX).
	shx1 := shx1 + (wz * aX).
	x := x + (w * aX).

	shy0 := shy0 + (wx * aY).
	sy := sy + (wy * aY).
	shy1 := shy1 + (wz * aY).
	y := y + (w * aY).

	shz0 := shz0 + (wx * aZ).
	shz1 := shz1 + (wy * aZ).
	sz := sz + (wz * aZ).
	z := z + (w * aZ)
]

{ #category : #'matrix - transformations' }
BlMatrix3D >> preScaleX: aX Y: aY Z: aZ [
	"Apply the scaling BEFORE my existing transformation.
	Any vector that is multiplied by the resulting matrix will first be scaled,
	then be transformed by the original transform"
	
	sx := sx * aX.
	shy0 := shy0 * aX.
	shz0 := shz0 * aX.
	wx := wx * aX.
	
	shx0 := shx0 * aY.
	sy := sy * aY.
	shz1 := shz1 * aY.
	wy := wy * aY.
	
	shz1 := shz1 * aZ.
	shy1 := shy1 * aZ.
	sz := sz * aZ.
	wz := wz * aZ
]

{ #category : #'matrix - transformations' }
BlMatrix3D >> preTranslateX: aX Y: aY Z: aZ [
	"Apply the translation BEFORE my existing transformation.
	Any vector that is multiplied by the resulting matrix will first be translated,
	then be transformed by the original transform"
	
	x := x + (aX * sx) + (aY * shx0) + (aZ * shx1).
	y := y + (aX * shy0) + (aY * sy) + (aZ * shy1).
	z := z + (aX * shz0) + (aY * shz1) + (aZ * sz).
	w := w + (aX * wx) + (aY * wy) + (aZ * wz)
]

{ #category : #printing }
BlMatrix3D >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.

	#(#x #y #z #w #sx #sy #sz #shx0 #shy0 #shz0 #shx1 #shy1 #shz1 #wx #wy #wz)
		do: [ :each |
			aStream
				nextPutAll: each;
				nextPut: $:;
				space.
			((self perform: each) printOn: aStream) ]
		separatedBy: [ aStream space ].

	aStream nextPut: $)
]

{ #category : #initialization }
BlMatrix3D >> quaternion: aQuaternion [
	"Set me to be a rotation matrix defined by a given quaternion"

	| normalized x2 y2 z2 xx xy xz yy yz zz _wx _wy _wz |

	"normalized quaternion"
	normalized := aQuaternion normalized.

	x2 := normalized x + normalized x.
	y2 := normalized y + normalized y.
	z2 := normalized z + normalized z.

	xx := normalized x * x2.
	xy := normalized x * y2.
	xz := normalized x * z2.

	yy := normalized y * y2.
	yz := normalized y * z2.
	zz := normalized z * z2.

	_wx := normalized w * x2.
	_wy := normalized w * y2.
	_wz := normalized w * z2.
	
	sx := (self class flushToZero: 1.0 - (yy + zz)).
	shy0 := (self class flushToZero: xy - _wz).
	shz0 := (self class flushToZero: xz + _wy).
	wx := 0.0.
	shx0 := (self class flushToZero: xy + _wz).
	sy := (self class flushToZero: 1.0 - (xx + zz)).
	shz1 := (self class flushToZero: yz - _wx).
	wy := 0.0.
	shx1 := (self class flushToZero: xz - _wy).
	shy1 := (self class flushToZero: yz + _wx).
	sz := (self class flushToZero: 1.0 - (xx + yy)).
	wz := 0.0.
	x := 0.0.
	y := 0.0.
	z := 0.0.
	w := 1.0
]

{ #category : #'matrix - transformations' }
BlMatrix3D >> rotateByRadians: aTheta around: aBlVector [
	"Apply a rotation transformation by a given amount of radians around a provided axis vector"

	| aRotationMatrix |
	aRotationMatrix := self class rotation: aTheta axis: aBlVector.
	self multiplyBy: aRotationMatrix
]

{ #category : #'matrix - transformations' }
BlMatrix3D >> rotateX: aTheta [
	"Rotate me around X-axis by aTheta degrees in radians"

	| cosTheta sinTheta temp |
	cosTheta := aTheta cos.
	(cosTheta closeTo: 0.0) ifTrue: [ cosTheta := 0.0 ].

	sinTheta := aTheta sin.
	(sinTheta closeTo: 0.0) ifTrue: [ sinTheta := 0.0 ].
	
	temp := shx0.
	shx0 := (cosTheta * shx0) + (sinTheta * shx1).
	shx1 := (sinTheta negated * temp) + (cosTheta * shx1).

	temp := sy.
	sy := (cosTheta * sy) + (sinTheta * shy1).
	shy1 := (sinTheta negated * temp) + (cosTheta * shy1).

	temp := shz1.
	shz1 := (cosTheta * shz1) + (sinTheta * sz).
	sz := (sinTheta negated * temp) + (cosTheta * sz).

	temp := wy.
	wy := (cosTheta * wy) + (sinTheta * wz).
	wz := (sinTheta negated * temp) + (cosTheta * wz)
]

{ #category : #initialization }
BlMatrix3D >> rotation: aTheta axis: aVector [
	"Set me to be a 3D matrix representing a rotation about a given axis vector by aTheta radians"

	| aNormalizedVector aX aY aZ cosTheta sinTheta sc sq |

	aVector length isZero ifTrue: [ ^ self ].
		
	aNormalizedVector := aVector normalized.
	
	aX := aNormalizedVector x.
	aY := aNormalizedVector y.
	aZ := aNormalizedVector z.
	
	cosTheta := self class flushToZero: aTheta cos.
	sinTheta := self class flushToZero: aTheta sin.
	
	"sin(aTheta / 2) * cos(aTheta / 2)"
	sc := sinTheta / 2.0.
	
	"pow(sin(aTheta / 2), 2)"
	sq := (1 - cosTheta) / 2.0.
	
	sx := 1 - (2.0 * ((aY * aY) + (aZ * aZ)) * sq).
	shy0 := 2 * ((aX * aY * sq) + (aZ * sc)).
	shz0 := 2 * ((aX * aZ * sq) - (aY * sc)).
	wx := 0.0.
	
	shx0 := 2 * ((aX * aZ * sq) - (aZ * sc)).
	sy := 1 - (2.0 * ((aX * aX) + (aZ * aZ)) * sq).
	shz1 := 2 * ((aY * aZ * sq) + (aX * sc)).
	wy := 0.0.
	
	shx1 := 2 * ((aX * aZ * sq) + (aY * sc)).
	shy1 := 2 * ((aY * aZ * sq) - (aX * sc)).
	sz := 1 - (2.0 * ((aX * aX) + (aY * aY)) * sq).
	wz := 0.0.
	
	x := 0.0.
	y := 0.0.
	z := 0.0.
	w := 1.0
]

{ #category : #accessing }
BlMatrix3D >> shx0 [
	^ shx0
]

{ #category : #accessing }
BlMatrix3D >> shx1 [
	^ shx1
]

{ #category : #accessing }
BlMatrix3D >> shy0 [
	^ shy0
]

{ #category : #accessing }
BlMatrix3D >> shy1 [
	^ shy1
]

{ #category : #accessing }
BlMatrix3D >> shz0 [
	^ shz0
]

{ #category : #accessing }
BlMatrix3D >> shz1 [
	^ shz1
]

{ #category : #accessing }
BlMatrix3D >> sx [
	^ sx
]

{ #category : #accessing }
BlMatrix3D >> sy [
	^ sy
]

{ #category : #accessing }
BlMatrix3D >> sz [
	^ sz
]

{ #category : #'matrix - transforming points' }
BlMatrix3D >> transformBounds: aBlBounds [
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"

	| quads minX maxX minY maxY|
	quads := { 
		self transformPoint: (BlPoint2D x: aBlBounds left y: aBlBounds top).
		self transformPoint: (BlPoint2D x: aBlBounds right y: aBlBounds top).
		self transformPoint: (BlPoint2D x: aBlBounds left y: aBlBounds bottom).
		self transformPoint: (BlPoint2D x: aBlBounds right y: aBlBounds bottom) }.
	
	minX := maxX := quads first x.
	minY := maxY := quads first y.
	
	quads do: [ :aQuad |
		minX := minX min: aQuad x.
		minY := minY min: aQuad y.
		maxX := maxX max: aQuad x.
		maxY := maxY max: aQuad y ].

	^ aBlBounds
		left: minX
		top: minY
		right: maxX
		bottom: maxY
]

{ #category : #'matrix - transforming points' }
BlMatrix3D >> transformPoint2D: aPoint2D [

	| aX aY aW |
	aX := (aPoint2D x * sx) + (aPoint2D y * shx0) + x.
	aY := (aPoint2D x * shy0) + (aPoint2D y * sy) + y.
	aW := (aPoint2D x * wx) + (aPoint2D y * wy) + w.

	^ BlPoint2D
		x: aX asFloat / aW
		y: aY asFloat / aW
]

{ #category : #'matrix - transforming points' }
BlMatrix3D >> transformPoint3D: aPoint3D [

	| aX aY aZ aW |
	aX := (aPoint3D x * sx) + (aPoint3D y * shx0) + (aPoint3D z * shx1) + x.
	aY := (aPoint3D x * shy0) + (aPoint3D y * sy) + (aPoint3D z * shy1) + y.
	aZ := (aPoint3D x * shz0) + (aPoint3D y * shz1) + (aPoint3D z * sz) + z.
	aW := (aPoint3D x * wx) + (aPoint3D y * wy) + (aPoint3D z * wz) + w.

	^ BlPoint3D
		x: aX asFloat / aW
		y: aY asFloat / aW
		z: aZ asFloat / aW
]

{ #category : #'matrix - transforming points' }
BlMatrix3D >> transformPoint4D: aPoint4D [

	| aX aY aZ aW |	
	aX := (aPoint4D x * sx) + (aPoint4D y * shx0) + (aPoint4D z * shx1) + (aPoint4D w * x).
	aY := (aPoint4D x * shy0) + (aPoint4D y * sy) + (aPoint4D z * shy1) + (aPoint4D w * y).
	aZ := (aPoint4D x * shz0) + (aPoint4D y * shz1) + (aPoint4D z * sz) + (aPoint4D w * z).
	aW := (aPoint4D x * wx) + (aPoint4D y * wy) + (aPoint4D z * wz) + (aPoint4D w * w).

	^ BlPoint4D
		x: aX
		y: aY
		z: aZ
		w: aW
]

{ #category : #'matrix - transformations' }
BlMatrix3D >> translateBy: aBlVector [

	| aTranslate3D |
	aTranslate3D := aBlVector asTranslate3D.

	self
		postTranslateX: aTranslate3D x
		Y: aTranslate3D y
		Z: aTranslate3D z
]

{ #category : #accessing }
BlMatrix3D >> w [
	^ w
]

{ #category : #accessing }
BlMatrix3D >> wx [
	^ wx
]

{ #category : #accessing }
BlMatrix3D >> wy [
	^ wy
]

{ #category : #accessing }
BlMatrix3D >> wz [
	^ wz
]

{ #category : #accessing }
BlMatrix3D >> x [
	^ x
]

{ #category : #accessing }
BlMatrix3D >> y [
	^ y
]

{ #category : #accessing }
BlMatrix3D >> z [
	^ z
]
