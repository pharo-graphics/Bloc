"
A BlMatrixDecomposition2DTest is a test class for testing the behavior of BlMatrixDecomposition2D
"
Class {
	#name : #BlMatrixDecomposition2DTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Math'
}

{ #category : #tests }
BlMatrixDecomposition2DTest >> testIdentity [

	| matrix decomposition |
	matrix := BlMatrix2D new.
	decomposition := matrix decomposition.

	self assert: decomposition sx  equals: 1.
	self assert: decomposition sy  equals: 1.
	self assert: decomposition shx equals: 0.
	self assert: decomposition shy equals: 0.
	self assert: decomposition angle equals: 0.
	self assert: decomposition scaleX equals: 1.
	self assert: decomposition scaleY equals: 1.
	self assert: decomposition translationX equals: 0.
	self assert: decomposition translationY equals: 0
]

{ #category : #tests }
BlMatrixDecomposition2DTest >> testInterpolateTo [

	| radians matrix0 matrix1 decomposition0 decomposition1 interpolatedDecomposition |
	matrix0 := BlMatrix2D new.
	radians := 90 degreesToRadians.
	matrix0 rotation: radians.
	decomposition0 := matrix0 decomposition.

	matrix1 := BlMatrix2D new.
	matrix1 translateBy: 4 @ 6.
	decomposition1 := matrix1 decomposition.

	interpolatedDecomposition := decomposition0 interpolate: 0.5 to: decomposition1.

	self assert: interpolatedDecomposition sx  equals: 1.0.
	self assert: interpolatedDecomposition sy  equals: 1.0.
	self assert: interpolatedDecomposition shx equals: 0.0.
	self assert: interpolatedDecomposition shy equals: 0.0.
	self assert: interpolatedDecomposition angle equals: 45.
	self assert: interpolatedDecomposition scaleX equals: 1.
	self assert: interpolatedDecomposition scaleY equals: 1.
	self assert: interpolatedDecomposition translationX equals: 2.
	self assert: interpolatedDecomposition translationY equals: 3
]

{ #category : #tests }
BlMatrixDecomposition2DTest >> testRotation [

	| radians matrix decomposition |
	matrix := BlMatrix2D new.
	radians := 45 degreesToRadians.
	matrix rotation: radians.
	decomposition := matrix decomposition.
	
	self assert: decomposition sx  equals: 1.
	self assert: decomposition sy  equals: 1.
	self assert: decomposition shx equals: 0.
	self assert: decomposition shy equals: 0.
	self assert: decomposition angle equals: 45.
	self assert: decomposition scaleX equals: 1.
	self assert: decomposition scaleY equals: 1.
	self assert: decomposition translationX equals: 0.
	self assert: decomposition translationY equals: 0.
	
	self assert: decomposition composition equals: matrix
]

{ #category : #tests }
BlMatrixDecomposition2DTest >> testScaleBy [

	| matrix decomposition |
	matrix := BlMatrix2D new.
	matrix scaleBy: 2 @ 3.
	decomposition := matrix decomposition.

	self assert: decomposition sx  equals: 1.
	self assert: decomposition sy  equals: 1.
	self assert: decomposition shx equals: 0.
	self assert: decomposition shy equals: 0.
	self assert: decomposition angle equals: 0.
	self assert: decomposition scaleX equals: 2.
	self assert: decomposition scaleY equals: 3.
	self assert: decomposition translationX equals: 0.
	self assert: decomposition translationY equals: 0.

	self assert: decomposition composition equals: matrix
]

{ #category : #tests }
BlMatrixDecomposition2DTest >> testTranslateBy [

	| matrix decomposition |
	matrix := BlMatrix2D new.
	matrix translateBy: 2 @ 3.
	decomposition := matrix decomposition.

	self assert: decomposition sx  equals: 1.0.
	self assert: decomposition sy  equals: 1.0.
	self assert: decomposition shx equals: 0.0.
	self assert: decomposition shy equals: 0.0.
	self assert: decomposition angle equals: 0.
	self assert: decomposition scaleX equals: 1.
	self assert: decomposition scaleY equals: 1.
	self assert: decomposition translationX equals: 2.
	self assert: decomposition translationY equals: 3.
	
	self assert: decomposition composition equals: matrix
]
