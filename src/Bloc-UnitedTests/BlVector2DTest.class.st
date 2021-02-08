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
