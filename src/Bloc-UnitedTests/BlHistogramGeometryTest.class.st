"
I have been automatically converted and probably manually tweaked from BlHistogramGeometryExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlHistogramGeometryTest,
	#superclass : #BlGeometryTest,
	#category : #'Bloc-UnitedTests-Geometry'
}

{ #category : #tests }
BlHistogramGeometryTest >> testBeHorizontal [

	| aHistogram |
	aHistogram := BlHistogramGeometry new
		              beHorizontal;
		              values: #( 0.2 1.0 0.5 );
		              yourself.

	self assert: aHistogram vertices equals: {
			(0.0 @ 100.0).
			(0.0 @ 80.0).
			(50.0 @ 80.0).
			(50.0 @ 0.0).
			(100.0 @ 0.0).
			(100.0 @ 50.0).
			(150.0 @ 50.0).
			(150.0 @ 100.0) }
]

{ #category : #tests }
BlHistogramGeometryTest >> testBeHorizontalInverted [

	| aHistogram |
	aHistogram := BlHistogramGeometry new
		              beHorizontalInverted;
		              values: #( 0.2 1.0 0.5 );
		              yourself.

	self assert: aHistogram vertices equals: {
			(0.0 @ 0.0).
			(0.0 @ 20.0).
			(50.0 @ 20.0).
			(50.0 @ 100.0).
			(100.0 @ 100.0).
			(100.0 @ 50.0).
			(150.0 @ 50.0).
			(150.0 @ 0.0) }
]

{ #category : #tests }
BlHistogramGeometryTest >> testBeVertical [

	| aHistogram |
	aHistogram := BlHistogramGeometry new
		              beVertical;
		              values: #( 0.2 1.0 0.5 );
		              yourself.

	self assert: aHistogram vertices equals: {
			(0.0 @ 0.0).
			(30.0 @ 0.0).
			(30.0 @ 33.333333333333336).
			(150.0 @ 33.333333333333336).
			(150.0 @ 66.66666666666667).
			(75.0 @ 66.66666666666667).
			(75.0 @ 100.0).
			(0.0 @ 100.0) }
]

{ #category : #tests }
BlHistogramGeometryTest >> testBeVerticalInverted [

	| aHistogram |
	aHistogram := BlHistogramGeometry new
		              beVerticalInverted;
		              values: #( 0.2 1.0 0.5 );
		              yourself.

	self assert: aHistogram vertices equals: {
			(150.0 @ 0.0).
			(120.0 @ 0.0).
			(120.0 @ 33.333333333333336).
			(0.0 @ 33.333333333333336).
			(0.0 @ 66.66666666666667).
			(75.0 @ 66.66666666666667).
			(75.0 @ 100.0).
			(150.0 @ 100.0) }
]

{ #category : #tests }
BlHistogramGeometryTest >> testDefault [

	| aHistogram |
	aHistogram := BlHistogramGeometry new.
	self assert: aHistogram extent equals: 150 @ 100.
	self
		assert: aHistogram values
		equals: #( 0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1 ).

	self assert: aHistogram isHorizontal.
	self deny: aHistogram isHorizontalInverted.
	self deny: aHistogram isVerticalInverted.
	self deny: aHistogram isVertical.

	self assert: aHistogram origin equals: 0 @ 100.
	self assert: aHistogram delta equals: 15 @ 0.
	self assert: aHistogram direction equals: 0 @ -1
]
