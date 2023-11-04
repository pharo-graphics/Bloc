"
I have been automatically converted and probably manually tweaked from BlVector2DExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : 'BlVectorTest',
	#superclass : 'TestCase',
	#category : 'Bloc-UnitedTests-Math',
	#package : 'Bloc-UnitedTests',
	#tag : 'Math'
}

{ #category : 'tests - conversions' }
BlVectorTest >> testAsBlocVector [
	
	| v |
	v := 10 asBlocVector.
	
	self assert: v x equals: 10.
	self assert: v y equals: 10.
]

{ #category : 'tests - conversions' }
BlVectorTest >> testAsBlocVectorNumber [
	
	| v |
	v := 10 asBlocVector.
	
	self assert: v x equals: 10.
	self assert: v y equals: 10.
]

{ #category : 'tests - conversions' }
BlVectorTest >> testAsBlocVectorPoint [
	
	| v |
	v := (10@20) asBlocVector.
	
	self assert: v x equals: 10.
	self assert: v y equals: 20.
]

{ #category : 'tests - maths' }
BlVectorTest >> testNormal [ 

	| v norm |
	v := (1@0) asBlocVector.
	norm := v normal.
	self assert: norm x equals: 0.
	self assert: norm y equals: 1.
	self assert: (v asPoint crossProduct: norm asPoint) equals: 1
]

{ #category : 'tests - conversions' }
BlVectorTest >> testSign [
	
	| signVector | 
	signVector := (100@ -2) asBlocVector sign.
	self assert: signVector x equals: 1.
	self assert: signVector y equals: -1.
]

{ #category : 'tests' }
BlVectorTest >> testSingleton [

	| singletonSelectors |
	singletonSelectors := #(xAxis yAxis zAxis zero one).
	
	singletonSelectors do: [ :each |
		self
			assert: (BlVector perform: each)
			identicalTo: (BlVector2D perform: each).
		self
			assert: (BlVector perform: each)
			identicalTo: (BlVector3D perform: each) ]
	
]

{ #category : 'tests' }
BlVectorTest >> testVector0degrees [
	
	| aVector |
	aVector := BlVector x: 10 y: 0.
	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 0.
	^ aVector
]

{ #category : 'tests' }
BlVectorTest >> testVector180degrees [
	
	| aVector |
	aVector := BlVector x: -10 y: 0.
	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 180.
	^ aVector
]

{ #category : 'tests' }
BlVectorTest >> testVector270degrees [
	
	| aVector |
	aVector := BlVector x: 0 y: -10.
	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 270.
	^ aVector
]

{ #category : 'tests - arithmetic' }
BlVectorTest >> testVector2DAddition [
	
	| aVector anotherVector sum |
	aVector := BlVector x: 10 y: 0.
	anotherVector :=  BlVector x: 100 y: 100.
	sum := aVector + anotherVector.
	self assert: sum x equals: 110.
	self assert: sum y equals: 100.
	^ sum
]

{ #category : 'tests - arithmetic' }
BlVectorTest >> testVector2DAdditionWith3D [
	
	| aVector anotherVector sum |
	aVector := BlVector x: 10 y: 0 z: -20.
	anotherVector :=  BlVector x: 100 y: 100.
	sum := anotherVector + aVector.
	self assert: sum x equals: 110.
	self assert: sum y equals: 100.
	self assert: sum z equals: -20.
	^ sum
]

{ #category : 'tests - arithmetic' }
BlVectorTest >> testVector2DMultiplication [
	
	| aVector mul |
	aVector := BlVector x: 10 y: 2.
	mul := aVector * 3.
	self assert: mul x equals: 30.
	self assert: mul y equals: 6.
	^ mul
]

{ #category : 'tests - arithmetic' }
BlVectorTest >> testVector2DMultiplicationConstantFirst [
	
	| aVector mul |
	aVector := BlVector x: 10 y: 2.
	mul :=  3 * aVector.
	self assert: mul x equals: 30.
	self assert: mul y equals: 6.
	^ mul
]

{ #category : 'tests' }
BlVectorTest >> testVector346degrees [
	
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

{ #category : 'tests - arithmetic' }
BlVectorTest >> testVector3DAddition [

	| aVector anotherVector sum |
	aVector := BlVector x: 10 y: 0 z: -20.
	anotherVector :=  BlVector x: 100 y: 100 z: 4.
	sum := aVector + anotherVector.
	self assert: sum x equals: 110.
	self assert: sum y equals: 100.
	self assert: sum z equals: -16.
	^ sum
]

{ #category : 'tests - arithmetic' }
BlVectorTest >> testVector3DAdditionWith2D [

	| aVector anotherVector sum |
	aVector := BlVector x: 10 y: 0 z: -20.
	anotherVector :=  BlVector x: 100 y: 100.
	sum := aVector + anotherVector.
	self assert: sum x equals: 110.
	self assert: sum y equals: 100.
	self assert: sum z equals: -20.
	^ sum
]

{ #category : 'tests - arithmetic' }
BlVectorTest >> testVector3DMultiplication [

	| aVector mul |
	aVector := BlVector x: 10 y: 2 z: -2.
	mul := aVector * 3.
	self assert: mul x equals: 30.
	self assert: mul y equals: 6.
	self assert: mul z equals: -6.
	^ mul
]

{ #category : 'tests' }
BlVectorTest >> testVector45degrees [
	
	| aVector |
	aVector := BlVector x: 10 y: 10.
	self
		assert: (aVector length - 14.14) abs < 0.1
		description: [ 'vector length must be 4.123 +/- 0.1, but is '
				, aVector length asString ].
	self assert: aVector degrees equals: 45.
	^ aVector
]

{ #category : 'tests - arithmetic' }
BlVectorTest >> testVectorMultiplicationConstantFirst [
	
	| aVector mul |
	aVector := BlVector x: 10 y: 2.
	mul :=  3 * aVector.
	self assert: mul x equals: 30.
	self assert: mul y equals: 6.
	^ mul
]
