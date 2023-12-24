"
A BlMatrix3DTest is a test class for testing the behavior of BlMatrix3D
"
Class {
	#name : #BlMatrix3DTest,
	#superclass : #TestCase,
	#category : 'Bloc-Tests-Basic-Math'
}

{ #category : #tests }
BlMatrix3DTest >> testInitialize [

	| matrix |
	matrix := BlMatrix3D new.
	self assert: matrix isIdentity.
	self assert: matrix shx0 equals: 0.0.
	self assert: matrix shy0 equals: 0.0.
	self assert: matrix shz0 equals: 0.0.
	self assert: matrix shx1 equals: 0.0.
	self assert: matrix shy1 equals: 0.0.
	self assert: matrix shz1 equals: 0.0.
	self assert: matrix sx equals: 1.0.
	self assert: matrix sy equals: 1.0.
	self assert: matrix sz equals: 1.0.
	self assert: matrix wx equals: 0.0.
	self assert: matrix wy equals: 0.0.
	self assert: matrix wz equals: 0.0.
	self assert: matrix x equals: 0.0.
	self assert: matrix y equals: 0.0.
	self assert: matrix z equals: 0.0.
	self assert: matrix w equals: 1.0.
]
