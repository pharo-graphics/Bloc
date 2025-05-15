"
A BlMatrix2DTest is a test class for testing the behavior of BlMatrix2D
"
Class {
	#name : #BlMatrix2DTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Math'
}

{ #category : #asserting }
BlMatrix2DTest >> assert: actualNumber closeTo: expectedNumber [
	"Explicit the precision"

	self assert: actualNumber closeTo: expectedNumber precision: 0.0001
]

{ #category : #tests }
BlMatrix2DTest >> testInitialize [

	| matrix |
	matrix := BlMatrix2D new.
	self assert: matrix isIdentity.
	self assert: matrix x equals: 0.0.
	self assert: matrix y equals: 0.0.
	self assert: matrix shx equals: 0.0.
	self assert: matrix shy equals: 0.0.
	self assert: matrix sx equals: 1.0.
	self assert: matrix sy equals: 1.0.
]

{ #category : #tests }
BlMatrix2DTest >> testInvert [

	| matrix |
	matrix := BlMatrix2D new.
	matrix x: 0.1; y: 0.2; sx: 0.3; sy: 0.4; shx: 0.5; shy: 0.6.
	matrix invert.

	self assert: matrix x   closeTo: -0.3333.
	self assert: matrix y   closeTo: 0.0.
	self assert: matrix sx  closeTo: -2.2222.
	self assert: matrix sy  closeTo: -1.6666.
	self assert: matrix shx closeTo: 2.7777.
	self assert: matrix shy closeTo: 3.3333
]

{ #category : #tests }
BlMatrix2DTest >> testRotation [

	| radians matrix |
	matrix := BlMatrix2D new.
	radians := 45 degreesToRadians.
	matrix rotation: radians.
	
	self assert: matrix x   equals: 0.
	self assert: matrix y   equals: 0.
	self assert: matrix sx  equals: radians cos.
	self assert: matrix sy  equals: radians cos.
	self assert: matrix shx equals: radians sin negated.
	self assert: matrix shy equals: radians sin
]

{ #category : #tests }
BlMatrix2DTest >> testScaleBy [

	| matrix |
	matrix := BlMatrix2D new.
	matrix scaleBy: 2 @ 3.
	
	self assert: matrix x   equals: 0.0.
	self assert: matrix y   equals: 0.0.
	self assert: matrix sx  equals: 2.0.
	self assert: matrix sy  equals: 3.0.
	self assert: matrix shx equals: 0.0.
	self assert: matrix shy equals: 0.0
]

{ #category : #tests }
BlMatrix2DTest >> testTranslateBy [

	| matrix |
	matrix := BlMatrix2D new.
	matrix translateBy: 2 @ 3.
	
	self assert: matrix x   equals: 2.0.
	self assert: matrix y   equals: 3.0.
	self assert: matrix sx  equals: 1.0.
	self assert: matrix sy  equals: 1.0.
	self assert: matrix shx equals: 0.0.
	self assert: matrix shy equals: 0.0
]
