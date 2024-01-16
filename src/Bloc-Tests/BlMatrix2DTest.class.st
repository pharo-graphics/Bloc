"
A BlMatrix2DTest is a test class for testing the behavior of BlMatrix2D
"
Class {
	#name : #BlMatrix2DTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Math'
}

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
BlMatrix2DTest >> testInverse [

	| matrix |
	matrix := BlMatrix2D new inverse.
	self assert: matrix isIdentity.
	self assert: matrix x equals: 0.0.
	self assert: matrix y equals: 0.0.
	self assert: matrix shx equals: 0.0.
	self assert: matrix shy equals: 0.0.
	self assert: matrix sx equals: 1.0.
	self assert: matrix sy equals: 1.0.
]
