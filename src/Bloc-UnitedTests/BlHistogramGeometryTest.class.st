"
I have been automatically converted and probably manually tweaked from BlHistogramGeometryExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlHistogramGeometryTest,
	#superclass : #BlGeometryTest,
	#category : #'Bloc-UnitedTests-Geometry'
}

{ #category : #metadata }
BlHistogramGeometryTest >> originClassName [
	"This test was generated from..."
	^ 'BlHistogramGeometryExamples'
]

{ #category : #tests }
BlHistogramGeometryTest >> testBottomToTop [
	<gtExample>
	| aHistogram |
	aHistogram := BlHistogramGeometry new
		beBottomToTop;
		values: #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).
	^ aHistogram
]

{ #category : #tests }
BlHistogramGeometryTest >> testDefault [
	<gtExample>
	| aHistogram |
	aHistogram := BlHistogramGeometry new.
	self assert: aHistogram extent equals: 150 @ 100.
	self
		assert: aHistogram values
		equals: #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).
	self assert: aHistogram isBottomToTop.
	self assert: aHistogram isTopToBottom not.
	self assert: aHistogram isRightToLeft not.
	self assert: aHistogram isLeftToRight not.
	self assert: aHistogram computeOrigin equals: 0 @ 100.
	self assert: aHistogram computeDelta equals: 15 @ 0.
	self assert: aHistogram computeLengthVector equals: 0 @ -1.
	^ aHistogram
]

{ #category : #tests }
BlHistogramGeometryTest >> testLeftToRight [
	<gtExample>
	| aHistogram |
	aHistogram := BlHistogramGeometry new
		beLeftToRight;
		values: #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).
	^ aHistogram
]

{ #category : #tests }
BlHistogramGeometryTest >> testRightToLeft [
	<gtExample>
	| aHistogram |
	aHistogram := BlHistogramGeometry new
		beRightToLeft;
		values: #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).
	^ aHistogram
]

{ #category : #tests }
BlHistogramGeometryTest >> testTopToBottom [
	<gtExample>
	| aHistogram |
	aHistogram := BlHistogramGeometry new
		beTopToBottom;
		values: #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).
	^ aHistogram
]
