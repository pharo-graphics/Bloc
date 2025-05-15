"
I represent a matrix used for 2D affine transformations.
https://en.wikipedia.org/wiki/Matrix_(mathematics)

My components are named according to mathematical convention:

 |  a11  a12  |                 |   sx    shy  |
 |  a21  a22  |       =>        |  shx     sy  |
 |  a31  a32  |                 |    x      y  |

"
Class {
	#name : #BlMatrix2D,
	#superclass : #BlMatrix,
	#instVars : [
		'x',
		'y',
		'shx',
		'shy',
		'sx',
		'sy'
	],
	#category : #'Bloc-Basic-Math'
}

{ #category : #'instance creation' }
BlMatrix2D class >> reflection: aDiagonalVector [
	"Return a matrix which corresponds to a reflection transformation with a given diagonal"

	^ self new
		  reflection: aDiagonalVector;
		  yourself
]

{ #category : #'instance creation' }
BlMatrix2D class >> rotation: anAngle [
	"Return a matrix which corresponds to a rotation transformation by given angle"

	^ self new
		  rotation: anAngle;
		  yourself
]

{ #category : #'instance creation' }
BlMatrix2D class >> scale: aBlVector [
	"Return a matrix which corresponds to a scale transformation by given factor"

	^ self new
		  scaleBy: aBlVector;
		  yourself
]

{ #category : #'instance creation' }
BlMatrix2D class >> shear: aCoefficientPoint [
	"Return a matrix which corresponds to a shear transformation by given coefficient"

	^ self new
		  shear: aCoefficientPoint;
		  yourself
]

{ #category : #'instance creation' }
BlMatrix2D class >> translation: aBlVector [
	"Return a matrix which corresponds to a translation transformation by given factor"

	^ self new
		  translateBy: aBlVector;
		  yourself
]

{ #category : #comparing }
BlMatrix2D >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].


	^ self sx = anObject sx and: [
		  self shy = anObject shy and: [
			  self shx = anObject shx and: [
				  self sy = anObject sy and: [
					  self x = anObject x and: [ self y = anObject y ] ] ] ] ]
]

{ #category : #'matrix - mathematical functions' }
BlMatrix2D >> decomposition [
	"Answer my decomposition, in a`BlMatrixDecomposition2D`.

	Based on: https://drafts.csswg.org/css-transforms/#decomposing-a-2d-matrix"
	
	| row0x row0y row1x row1y scaleX scaleY determinant angle |
	row0x := sx.
	row0y := shy.
	row1x := shx.
	row1y := sy.

	scaleX := ((row0x * row0x) + (row0y * row0y)) sqrt.
	scaleY := ((row1x * row1x) + (row1y * row1y)) sqrt.
	
	"If determinant is negative, one axis was flipped."
	determinant := (row0x * row1y) - (row0y * row1x).
	determinant < 0 ifTrue: [ 
		row0x < row1y
			ifTrue: [ scaleX := scaleX negated ]
			ifFalse: [ scaleY := scaleY negated ] ].
	
	"Renormalize matrix to remove scale."
	scaleX isZero ifFalse: [
		row0x := row0x * (1.0 / scaleX).
		row0y := row0y * (1.0 / scaleX) ].
	scaleY isZero ifFalse: [
		row1x := row1x * (1.0 / scaleY).
		row1y := row1y * (1.0 / scaleY) ].
	
	"Compute rotation and renormalize matrix."
	angle := row0y arcTan: row0x.
	angle isZero ifFalse: [ 
		| sn cs m11 m12 m21 m22 |
		sn := row0y negated.
		cs := row0x.
		m11 := row0x.
		m12 := row0y.
		m21 := row1x.
		m22 := row1y.
		row0x := (cs * m11) + (sn * m21).
		row0y := (cs * m12) + (sn * m22).
		row1x := (sn negated * m11) + (cs * m21).
		row1y := (sn negated * m12) + (cs * m22) ].

	"Convert into degrees because our rotation functions expect it."
	angle := angle radiansToDegrees.
	
	^ BlMatrixDecomposition2D new
		translationX: x;
		translationY: y;
		scaleX: scaleX;
		scaleY: scaleY;
		angle: angle;
		sx: row0x;
		sy: row1y;
		shx: row1x;
		shy: row0y;
		yourself
]

{ #category : #'matrix - mathematical functions' }
BlMatrix2D >> determinant [
	"Compute and return my determinant"
	
	^ (sx * sy) - (shy * shx)
]

{ #category : #comparing }
BlMatrix2D >> hash [

	^ ((((self sx hash bitXor: self shy hash) bitXor: self shx hash)
		    bitXor: self sy hash) bitXor: self x hash) bitXor: self y hash
]

{ #category : #initialization }
BlMatrix2D >> initialize [

	super initialize.

	sx := 1.0.
	shy := 0.0.
	shx := 0.0.
	sy := 1.0.
	x := 0.0.
	y := 0.0
]

{ #category : #'matrix - mathematical functions' }
BlMatrix2D >> inverse [
	"In-place inverse me.
	Throw BlSingularMatrixError if matrix is singular (non-invertible or degenerate)"

	self
		deprecated: 'Use #invert'
		transformWith:
			'`@receiver inverse' -> 
			'`@receiver invert'.
	
	self invert
]

{ #category : #'matrix - mathematical functions' }
BlMatrix2D >> invert [
	"In-place inverse me.
	Throw BlSingularMatrixError if matrix is singular (non-invertible or degenerate)"

	| a b c d e f determinant inverseDeterminant |
	a := sy.
	b := shx negated.
	c := (shx * y) - (sy * x).
	d := shy negated.
	e := sx.
	f := (x * shy) - (sx * y).
	
	determinant := self determinant.
	determinant isZero ifTrue: [
		BlSingularMatrixError signal: 'Matrix is singular and can not be inverted!' ].
		
	inverseDeterminant := 1.0 / determinant.
	
	sx := inverseDeterminant * a.
	shy := inverseDeterminant * d.
	shx := inverseDeterminant * b.
	sy := inverseDeterminant * e.
	x := inverseDeterminant * c.
	y := inverseDeterminant * f
]

{ #category : #'matrix - mathematical functions' }
BlMatrix2D >> inverted [
	"Return a new instance that is my inverse.
	Signal a `BlSingularMatrixError` if matrix is singular (non-invertible or degenerate)"
	
	^ self copy invert
]

{ #category : #testing }
BlMatrix2D >> is2D [
	"Return true if matrix is 2D, false otherwise"
	
	^ true
]

{ #category : #'matrix - testing' }
BlMatrix2D >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"

	^ sx = 1.0 and: [
		shy = 0.0 and: [
			shx = 0.0 and: [
				sy = 1.0 and: [
					x = 0.0 and: [
						y = 0.0 ] ] ] ] ]
]

{ #category : #initialization }
BlMatrix2D >> matrix: aMatrix [
	"Copy matrix values"
	
	sx := aMatrix sx.
	shy := aMatrix shy.
	shx := aMatrix shx.
	sy := aMatrix sy.
	x := aMatrix x.
	y := aMatrix y
]

{ #category : #'matrix - transformations' }
BlMatrix2D >> multiplyBy: aMatrix2D [
	"Perform a right multiplication by a given 2D matrix"

	| r11 r12 r21 r22 r31 r32 |
	
	r11 := (sx * aMatrix2D sx) + (shy * aMatrix2D shx).
	r12 := (sx * aMatrix2D shy) + (shy * aMatrix2D sy).
	r21 := (shx * aMatrix2D sx) + (sy * aMatrix2D shx).
	r22 := (shx * aMatrix2D shy) + (sy * aMatrix2D sy).
	r31 := (x * aMatrix2D sx) + (y * aMatrix2D shx) + aMatrix2D x.
	r32 := (x * aMatrix2D shy) + (y * aMatrix2D sy) + aMatrix2D y.

	sx := r11.
	shy := r12.
	shx := r21.
	sy := r22.
	x := r31.
	y := r32
]

{ #category : #'matrix - transformations' }
BlMatrix2D >> perspective: aDepth [
	"2D matrix does not have a perspective components"
]

{ #category : #printing }
BlMatrix2D >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.

	#(x y sx sy shx shy)
		do: [ :each |
			aStream
				nextPutAll: each;
				nextPut: $:;
				space.
			((self perform: each) printOn: aStream) ]
		separatedBy: [ aStream space ].

	aStream nextPut: $)
]

{ #category : #'matrix - transformations' }
BlMatrix2D >> reflectBy: aDiagonalVector [
	"Apply a reflection transformation given by a diagonal vector"
		
	"Apply the reflection AFTER my existing transformation."
	self multiplyBy: (self class reflection: aDiagonalVector)
]

{ #category : #initialization }
BlMatrix2D >> reflection: aDiagonalVector [
	"Set me to be a 2D matrix representing a reflection defined by a given diagonal"

	x := 0.0.
	y := 0.0.
	sx := aDiagonalVector x.
	sy := aDiagonalVector y.
	shx := 0.
	shy := 0
]

{ #category : #'matrix - transformations' }
BlMatrix2D >> rotateByRadians: anAngle around: aBlVector [
	"Apply a rotation transformation by a given amount of radians around a provided axis vector"

	"2D Matrix is incompatible with 3D transformation"
	self assert: [ aBlVector = BlVector zAxis ].
		
	"Apply the rotation AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be rotated by given angle in radians"
	
	self multiplyBy: (self class rotation: anAngle)
]

{ #category : #initialization }
BlMatrix2D >> rotation: anAngle [
	"Set me to be a 2D matrix representing a rotation by a given angle in radians"

	| aSin aCos |
	aSin := anAngle sin.
	aCos := anAngle cos.
	
	x := 0.0.
	y := 0.0.
	sx := aCos.
	sy := aCos.
	shx := aSin negated.
	shy := aSin
]

{ #category : #'matrix - transformations' }
BlMatrix2D >> scaleBy: aBlVector [
	"Apply a scaling defined by a given vector"

	| aScale3D |
	aScale3D := aBlVector asScale3D.

	"2D Matrix is incompatible with 3D transformation"
	self assert: [ aScale3D z closeTo: 1 ].
		
	"Apply the scale AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be scaled by given scale factor"

	sx := sx * aScale3D x.
	shy := shy * aScale3D y.
	shx := shx * aScale3D x.
	sy := sy * aScale3D y.
	x := x * aScale3D x.
	y := y * aScale3D y
]

{ #category : #initialization }
BlMatrix2D >> shear: aCoefficientPoint [
	"Set me to be a 2D matrix representing a shear by a given coefficient (shx, shy)"
	
	x := 0.0.
	y := 0.0.
	sx := 1.0.
	sy := 1.0.
	shx := aCoefficientPoint x.
	shy := aCoefficientPoint y
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> shx [
	"Returns the X coordinate shearing element of the affine transformation matrix"

	^ shx
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> shx: aNumber [

	shx := aNumber
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> shy [
	"Returns the Y coordinate shearing element of the affine transformation matrix"
	
	^ shy
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> shy: aNumber [

	shy := aNumber
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> sx [
	"Returns the X coordinate scaling element of the affine transformation matrix"

	^ sx
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> sx: aNumber [

	sx := aNumber
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> sy [
	"Returns the Y coordinate scaling element of the affine transformation matrix"

	^ sy
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> sy: aNumber [

	sy := aNumber
]

{ #category : #'matrix - transforming points' }
BlMatrix2D >> transformBounds: aBlBounds [
	"In-place transform given `BlBounds` according to my transformation.
	(local to global transformation)"

	| newLeft newTop newRight newBottom left top right bottom quadTopLeftX quadTopLeftY quadTopRightX quadTopRightY quadBottomLeftX quadBottomLeftY quadBottomRightX quadBottomRightY |
	self isIdentity ifTrue: [ ^ aBlBounds ].

	left := aBlBounds left.
	top := aBlBounds top.
	right := aBlBounds right.
	bottom := aBlBounds bottom.

	quadTopLeftX := left * sx + (top * shx) + x.
	quadTopLeftY := left * shy + (top * sy) + y.
	quadTopRightX := right * sx + (top * shx) + x.
	quadTopRightY := right * shy + (top * sy) + y.
	quadBottomLeftX := left * sx + (bottom * shx) + x.
	quadBottomLeftY := left * shy + (bottom * sy) + y.
	quadBottomRightX := right * sx + (bottom * shx) + x.
	quadBottomRightY := right * shy + (bottom * sy) + y.

	newLeft := ((quadTopLeftX min: quadTopRightX) min: quadBottomLeftX)
		           min: quadBottomRightX.
	newRight := ((quadTopLeftX max: quadTopRightX) max: quadBottomLeftX)
		            max: quadBottomRightX.

	newTop := ((quadTopLeftY min: quadTopRightY) min: quadBottomLeftY)
		          min: quadBottomRightY.

	newBottom := ((quadTopLeftY max: quadTopRightY) max: quadBottomLeftY)
		             max: quadBottomRightY.

	aBlBounds
		left: newLeft
		top: newTop
		right: newRight
		bottom: newBottom.

	^ aBlBounds
]

{ #category : #'matrix - transforming points' }
BlMatrix2D >> transformPoint2D: aPoint2D [
	
	^ self transformX: aPoint2D x Y: aPoint2D y
]

{ #category : #'matrix - transforming points' }
BlMatrix2D >> transformX: aX Y: aY [

	| newX newY |
	newX := aX * sx + (aY * shx) + x.
	newY := aX * shy + (aY * sy) + y.

	^ newX @ newY
]

{ #category : #'matrix - transforming points' }
BlMatrix2D >> transformX: aX withY: aY [

	^ (aX * sx) + (aY * shx) + x
]

{ #category : #'matrix - transforming points' }
BlMatrix2D >> transformY: aY withX: aX [

	^ (aX * shy) + (aY * sy) + y
]

{ #category : #'matrix - transformations' }
BlMatrix2D >> translateBy: aBlVector [
	"Apply a translation by a given vector"

	| aTranslate3D |
	aTranslate3D := aBlVector asTranslate3D.

	"2D Matrix is incompatible with 3D transformation"
	self assert: [ aTranslate3D z isZero ].

	"Apply the translation AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be translated by given translation"
	x := x + aTranslate3D x.
	y := y + aTranslate3D y
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> x [
	"Returns the X coordinate of the translation element of the affine transformation matrix"
	
	^ x
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> x: aNumber [

	x := aNumber
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> y [
	"Returns the Y coordinate of the translation element of the affine transformation matrix"

	^ y
]

{ #category : #'matrix - accessing' }
BlMatrix2D >> y: aNumber [

	y := aNumber
]
