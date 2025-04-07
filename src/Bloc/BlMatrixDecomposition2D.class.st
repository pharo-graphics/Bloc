"
I am a decomposition of 2D matrix.

https://drafts.csswg.org/css-transforms/#interpolation-of-2d-matrices

"
Class {
	#name : #BlMatrixDecomposition2D,
	#superclass : #BlMatrixDecomposition,
	#instVars : [
		'translation',
		'scale',
		'angle',
		'sx',
		'sy',
		'shx',
		'shy'
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
	aMatrix x: (translation x * aMatrix sx) + (translation y * aMatrix shx).
	aMatrix y: (translation x * aMatrix shy) + (translation y * aMatrix sy).
	
	"Rotate matrix"
	aMatrix := (BlMatrix2D rotation: angle degreesToRadians) multiplyBy: aMatrix.

	"Scale matrix."
	aMatrix sx: aMatrix sx * scale x.
	aMatrix shy: aMatrix shy * scale x.
	aMatrix shx: aMatrix shx * scale y.
	aMatrix sy: aMatrix sy * scale y.
	
	^ aMatrix
]

{ #category : #'matrix - mathematical functions' }
BlMatrixDecomposition2D >> interpolate: aFactor to: anotherDecomposition [
	"Algorithm is based on https://drafts.csswg.org/css-transforms/#interpolation-of-decomposed-2d-matrix-values"

	| aScaleX aScaleY anAngle anotherAngle |
	aScaleX := scale x.
	aScaleY := scale y.
	anAngle := angle.
	anotherAngle := anotherDecomposition angle.

	((aScaleX < 0 and: [ anotherDecomposition scale y < 0 ]) or:
	[ aScaleY < 0 and: [ anotherDecomposition scale x < 0 ] ])
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
		translation: translation + ((anotherDecomposition translation - translation) * aFactor);
		scale: scale + ((anotherDecomposition scale - (BlVector x: aScaleX y: aScaleY)) * aFactor);
		angle: anAngle + ((anotherAngle - anAngle) * aFactor);
		sx: sx + ((anotherDecomposition sx - sx) * aFactor);
		sy: sy + ((anotherDecomposition sy - sy) * aFactor);
		shx: shx + ((anotherDecomposition shx - shx) * aFactor);
		shy: shy + ((anotherDecomposition shy - shy) * aFactor);
		yourself
]

{ #category : #accessing }
BlMatrixDecomposition2D >> scale [

	^ scale
]

{ #category : #accessing }
BlMatrixDecomposition2D >> scale: aBlVector [

	scale := aBlVector
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
BlMatrixDecomposition2D >> translation [
	"Return the vector (`BlVector`) corresponding to the translation."
	
	^ translation
]

{ #category : #accessing }
BlMatrixDecomposition2D >> translation: aBlVector [

	translation := aBlVector
]
