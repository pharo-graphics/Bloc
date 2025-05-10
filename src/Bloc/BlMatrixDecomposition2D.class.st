"
I am a decomposition of 2D matrix.

https://drafts.csswg.org/css-transforms/#interpolation-of-2d-matrices

"
Class {
	#name : #BlMatrixDecomposition2D,
	#superclass : #BlMatrixDecomposition,
	#instVars : [
		'angle',
		'sx',
		'sy',
		'shx',
		'shy',
		'scaleX',
		'scaleY',
		'translationX',
		'translationY'
	],
	#category : #'Bloc-Basic-Math'
}

{ #category : #accessing }
BlMatrixDecomposition2D >> angle [
	"Return a decomposed rotation angle in degrees"

	^ angle
]

{ #category : #accessing }
BlMatrixDecomposition2D >> angle: aNumberOfDegrees [

	angle := aNumberOfDegrees
]

{ #category : #'matrix - mathematical functions' }
BlMatrixDecomposition2D >> composition [

	| aMatrix |
	aMatrix := BlMatrix2D new.
	aMatrix sx: sx.
	aMatrix sy: sy.
	aMatrix shx: shx.
	aMatrix shy: shy.
	
	"Translate matrix"
	aMatrix x: (translationX * aMatrix sx) + (translationY * aMatrix shx).
	aMatrix y: (translationX * aMatrix shy) + (translationY * aMatrix sy).
	
	"Rotate matrix"
	aMatrix := (BlMatrix2D rotation: angle degreesToRadians) multiplyBy: aMatrix.

	"Scale matrix."
	aMatrix sx: aMatrix sx * scaleX.
	aMatrix shy: aMatrix shy * scaleX.
	aMatrix shx: aMatrix shx * scaleY.
	aMatrix sy: aMatrix sy * scaleY.
	
	^ aMatrix
]

{ #category : #'matrix - mathematical functions' }
BlMatrixDecomposition2D >> interpolate: aFactor to: anotherDecomposition [
	"Algorithm is based on https://drafts.csswg.org/css-transforms/#interpolation-of-decomposed-2d-matrix-values"

	| aScaleX aScaleY anAngle anotherAngle |
	aScaleX := scaleX.
	aScaleY := scaleY.
	anAngle := angle.
	anotherAngle := anotherDecomposition angle.

	((aScaleX < 0 and: [ anotherDecomposition scaleY < 0 ]) or:
	[ aScaleY < 0 and: [ anotherDecomposition scaleX < 0 ] ])
		ifTrue: [
			aScaleX := aScaleX negated.
			aScaleY := aScaleY negated.
			anAngle := anAngle < 0
				ifTrue: [ anAngle + 180 ]
				ifFalse: [ anAngle - 180 ] ].
	
	"Don't rotate the long way around."
	anAngle isZero ifTrue: [ anAngle := 360 ].
	anotherAngle isZero ifTrue: [ anotherAngle := 360 ].

	(anAngle - anotherAngle) abs > 180 ifTrue: [ 
		anAngle > anotherAngle
			ifTrue: [ anAngle := anAngle - 360 ]
			ifFalse: [ anotherAngle := anotherAngle - 360 ] ].
	
	"Interpolate all values."
	^ self class new
		translationX: translationX + ((anotherDecomposition translationX - translationX) * aFactor);
		translationY: translationY + ((anotherDecomposition translationY - translationY) * aFactor);
		scaleX: scaleX + ((anotherDecomposition scaleX - aScaleX) * aFactor);
		scaleY: scaleY + ((anotherDecomposition scaleY - aScaleY) * aFactor);
		angle: anAngle + ((anotherAngle - anAngle) * aFactor);
		sx: sx + ((anotherDecomposition sx - sx) * aFactor);
		sy: sy + ((anotherDecomposition sy - sy) * aFactor);
		shx: shx + ((anotherDecomposition shx - shx) * aFactor);
		shy: shy + ((anotherDecomposition shy - shy) * aFactor);
		yourself
]

{ #category : #printing }
BlMatrixDecomposition2D >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' angle: ';
		print: angle.
	aStream
		nextPutAll: ' scale: ';
		print: scaleX @ scaleY.
	aStream
		nextPutAll: ' translation: ';
		print: translationX @ translationY.
	aStream
		nextPutAll: ' s: ';
		print: sx @ sy.
	aStream
		nextPutAll: ' sh: ';
		print: shx @ shy
]

{ #category : #accessing }
BlMatrixDecomposition2D >> scaleX [

	^ scaleX
]

{ #category : #accessing }
BlMatrixDecomposition2D >> scaleX: aNumber [

	scaleX := aNumber
]

{ #category : #accessing }
BlMatrixDecomposition2D >> scaleY [

	^ scaleY
]

{ #category : #accessing }
BlMatrixDecomposition2D >> scaleY: aNumber [

	scaleY := aNumber
]

{ #category : #accessing }
BlMatrixDecomposition2D >> shx [

	^ shx
]

{ #category : #accessing }
BlMatrixDecomposition2D >> shx: aNumber [

	shx := aNumber
]

{ #category : #accessing }
BlMatrixDecomposition2D >> shy [

	^ shy
]

{ #category : #accessing }
BlMatrixDecomposition2D >> shy: aNumber [

	shy := aNumber
]

{ #category : #accessing }
BlMatrixDecomposition2D >> sx [

	^ sx
]

{ #category : #accessing }
BlMatrixDecomposition2D >> sx: aNumber [

	sx := aNumber
]

{ #category : #accessing }
BlMatrixDecomposition2D >> sy [

	^ sy
]

{ #category : #accessing }
BlMatrixDecomposition2D >> sy: aNumber [

	sy := aNumber
]

{ #category : #accessing }
BlMatrixDecomposition2D >> translationX [

	^ translationX
]

{ #category : #accessing }
BlMatrixDecomposition2D >> translationX: aNumber [

	translationX := aNumber
]

{ #category : #accessing }
BlMatrixDecomposition2D >> translationY [

	^ translationY
]

{ #category : #accessing }
BlMatrixDecomposition2D >> translationY: aNumber [

	translationY := aNumber
]
