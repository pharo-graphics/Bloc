"
I have been automatically converted and probably manually tweaked from BlVector2DExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlVector2DTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests'
}

{ #category : #metadata }
BlVector2DTest >> originClassName [
	"This test was generated from..."
	^ 'BlVector2DExamples'
]

{ #category : #tests }
BlVector2DTest >> testVector0degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 10 y: 0.
	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 0.
	^ aVector
]

{ #category : #tests }
BlVector2DTest >> testVector180degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: -10 y: 0.
	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 180.
	^ aVector
]

{ #category : #tests }
BlVector2DTest >> testVector270degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 0 y: -10.
	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 270.
	^ aVector
]

{ #category : #'tests - arithmetic' }
BlVector2DTest >> testVector2DAddition [
	<gtExample>
	| aVector anotherVector sum |
	aVector := BlVector x: 10 y: 0.
	anotherVector :=  BlVector x: 100 y: 100.
	sum := aVector + anotherVector.
	self assert: sum x equals: 110.
	self assert: sum y equals: 100.
	^ sum
]

{ #category : #'tests - arithmetic' }
BlVector2DTest >> testVector2DAdditionWith3D [
	<gtExample>
	| aVector anotherVector sum |
	aVector := BlVector x: 10 y: 0 z: -20.
	anotherVector :=  BlVector x: 100 y: 100.
	sum := anotherVector + aVector.
	self assert: sum x equals: 110.
	self assert: sum y equals: 100.
	self assert: sum z equals: -20.
	^ sum
]

{ #category : #'tests - arithmetic' }
BlVector2DTest >> testVector2DMultiplication [
	<gtExample>
	| aVector mul |
	aVector := BlVector x: 10 y: 2.
	mul := aVector * 3.
	self assert: mul x equals: 30.
	self assert: mul y equals: 6.
	^ mul
]

{ #category : #'tests - arithmetic' }
BlVector2DTest >> testVector2DMultiplicationConstantFirst [
	<gtExample>
	| aVector mul |
	aVector := BlVector x: 10 y: 2.
	mul :=  3 * aVector.
	self assert: mul x equals: 30.
	self assert: mul y equals: 6.
	^ mul
]

{ #category : #tests }
BlVector2DTest >> testVector346degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 4 y: -1.
	self
		assert: (aVector length - 4.123) abs < 0.1
		description: [ 'vector length must be 4.123 +/- 0.1, but is '
				, aVector length asString ].
	self
		assert: (aVector degrees - 346) abs < 0.1
		description: [ 'vector degrees must be 346 +/- 0.1, but is '
				, aVector degrees asString ].
	^ aVector
]

{ #category : #'tests - arithmetic' }
BlVector2DTest >> testVector3DAddition [
	<gtExample>
	| aVector anotherVector sum |
	aVector := BlVector x: 10 y: 0 z: -20.
	anotherVector :=  BlVector x: 100 y: 100 z: 4.
	sum := aVector + anotherVector.
	self assert: sum x equals: 110.
	self assert: sum y equals: 100.
	self assert: sum z equals: -16.
	^ sum
]

{ #category : #'tests - arithmetic' }
BlVector2DTest >> testVector3DAdditionWith2D [
	<gtExample>
	| aVector anotherVector sum |
	aVector := BlVector x: 10 y: 0 z: -20.
	anotherVector :=  BlVector x: 100 y: 100.
	sum := aVector + anotherVector.
	self assert: sum x equals: 110.
	self assert: sum y equals: 100.
	self assert: sum z equals: -20.
	^ sum
]

{ #category : #'tests - arithmetic' }
BlVector2DTest >> testVector3DMultiplication [
	<gtExample>
	| aVector mul |
	aVector := BlVector x: 10 y: 2 z: -2.
	mul := aVector * 3.
	self assert: mul x equals: 30.
	self assert: mul y equals: 6.
	self assert: mul z equals: -6.
	^ mul
]

{ #category : #tests }
BlVector2DTest >> testVector45degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 10 y: 10.
	self
		assert: (aVector length - 14.14) abs < 0.1
		description: [ 'vector length must be 4.123 +/- 0.1, but is '
				, aVector length asString ].
	self assert: aVector degrees equals: 45.
	^ aVector
]

{ #category : #'tests - arithmetic' }
BlVector2DTest >> testVectorMultiplicationConstantFirst [
	<gtExample>
	| aVector mul |
	aVector := BlVector x: 10 y: 2.
	mul :=  3 * aVector.
	self assert: mul x equals: 30.
	self assert: mul y equals: 6.
	^ mul
]
