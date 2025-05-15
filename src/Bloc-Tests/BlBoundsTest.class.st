"
A BlBoundsTest is a test class for testing the behavior of BlBounds
"
Class {
	#name : #BlBoundsTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Bounds'
}

{ #category : #tests }
BlBoundsTest >> testARectangleContainsItsOrigin [

	| bounds |
	bounds := BlBounds origin: 10 @ 10 corner: 20 @ 20.
	self assert: (bounds containsPoint: bounds origin)
]

{ #category : #tests }
BlBoundsTest >> testARectangleDoesNotContainItsCorner [

	| bounds |
	bounds := BlBounds origin: 10 @ 10 corner: 20 @ 20.
	self deny: (bounds containsPoint: bounds corner)
]

{ #category : #tests }
BlBoundsTest >> testCompress [

	| aBounds |
	aBounds := BlBounds left: 1.9 top: 2.9 right: 3.9 bottom: 4.9.
	aBounds compress.
	
	self assert: aBounds left equals: 2.
	self assert: aBounds top equals: 3.
	self assert: aBounds right equals: 3.
	self assert: aBounds bottom equals: 4.

	aBounds left: 1.2 top: 2.2 right: 3.2 bottom: 4.2.
	aBounds compress.
	
	self assert: aBounds left equals: 2.
	self assert: aBounds top equals: 3.
	self assert: aBounds right equals: 3.
	self assert: aBounds bottom equals: 4
]

{ #category : #tests }
BlBoundsTest >> testContainsPoint [

	| bounds |
	bounds := BlBounds origin: 10 @ 10 corner: 20 @ 20.
	self assert: (bounds containsPoint: bounds center)
]

{ #category : #tests }
BlBoundsTest >> testExpand [

	| aBounds |
	aBounds := BlBounds left: 1.9 top: 2.9 right: 3.9 bottom: 4.9.
	aBounds expand.
	
	self assert: aBounds left equals: 1.
	self assert: aBounds top equals: 2.
	self assert: aBounds right equals: 4.
	self assert: aBounds bottom equals: 5.

	aBounds left: 1.2 top: 2.2 right: 3.2 bottom: 4.2.
	aBounds expand.
	
	self assert: aBounds left equals: 1.
	self assert: aBounds top equals: 2.
	self assert: aBounds right equals: 4.
	self assert: aBounds bottom equals: 5
]

{ #category : #tests }
BlBoundsTest >> testFromRectangle [

	| aBounds |
	aBounds := BlBounds fromRectangle: (Rectangle origin: 1.2 @ 3.4 corner: 5.6 @ 7.8).
	
	self assert: aBounds left equals: 1.2.
	self assert: aBounds top equals: 3.4.
	self assert: aBounds right equals: 5.6.
	self assert: aBounds bottom equals: 7.8.

	aBounds rectangle: (Rectangle origin: -8.7 @ -6.5 corner: 4.3 @ 2.1).
	
	self assert: aBounds left equals: -8.7.
	self assert: aBounds top equals: -6.5.
	self assert: aBounds right equals: 4.3.
	self assert: aBounds bottom equals: 2.1
]

{ #category : #tests }
BlBoundsTest >> testLeftTopRightBottom [

	| aBounds |
	aBounds := BlBounds left: 1.2 top: 3.4 right: 5.6 bottom: 7.8.
	
	self assert: aBounds left equals: 1.2.
	self assert: aBounds top equals: 3.4.
	self assert: aBounds right equals: 5.6.
	self assert: aBounds bottom equals: 7.8.

	aBounds left: -8.7 top: -6.5 right: 4.3 bottom: 2.1.
	
	self assert: aBounds left equals: -8.7.
	self assert: aBounds top equals: -6.5.
	self assert: aBounds right equals: 4.3.
	self assert: aBounds bottom equals: 2.1
]

{ #category : #tests }
BlBoundsTest >> testLeftTopWidthHeight [

	| aBounds |
	aBounds := BlBounds left: 1.2 top: 3.4 width: 5.6 height: 7.8.
	
	self assert: aBounds left equals: 1.2.
	self assert: aBounds top equals: 3.4.
	self assert: aBounds right equals: 1.2 + 5.6.
	self assert: aBounds bottom equals: 3.4 + 7.8
]

{ #category : #tests }
BlBoundsTest >> testMerge [

	| aBounds |
	aBounds :=
		BlBounds
			left: 1
			top: 2
			right: 3
			bottom: 4.

	aBounds merge:
		(BlBounds
			left: 5
			top: 6
			right: 7
			bottom: 8).

	self assert: aBounds left equals: 1.
	self assert: aBounds top equals: 2.
	self assert: aBounds right equals: 7.
	self assert: aBounds bottom equals: 8.

	aBounds merge:
		(Rectangle
			left: -4
			right: -3
			top: -2
			bottom: -1).

	self assert: aBounds left equals: -4.
	self assert: aBounds right equals: 7.
	self assert: aBounds top equals: -2.
	self assert: aBounds bottom equals: 8
]

{ #category : #tests }
BlBoundsTest >> testNew [

	| aBounds |
	aBounds := BlBounds new.
	
	self assert: aBounds left equals: 0.0.
	self assert: aBounds top equals: 0.0.
	self assert: aBounds right equals: 0.0.
	self assert: aBounds bottom equals: 0.0
]

{ #category : #tests }
BlBoundsTest >> testOriginCorner [

	| aBounds |
	aBounds := BlBounds origin: 1.2 @ 3.4 corner: 5.6 @ 7.8.
	
	self assert: aBounds left equals: 1.2.
	self assert: aBounds top equals: 3.4.
	self assert: aBounds right equals: 5.6.
	self assert: aBounds bottom equals: 7.8.

	aBounds origin: -8.7 @ -6.5 corner: 4.3 @ 2.1.
	
	self assert: aBounds left equals: -8.7.
	self assert: aBounds top equals: -6.5.
	self assert: aBounds right equals: 4.3.
	self assert: aBounds bottom equals: 2.1
]

{ #category : #tests }
BlBoundsTest >> testOriginExtent [

	| aBounds |
	aBounds := BlBounds origin: 1.2 @ 3.4 extent: 5.6 @ 7.8.
	
	self assert: aBounds left equals: 1.2.
	self assert: aBounds top equals: 3.4.
	self assert: aBounds right equals: 1.2 + 5.6.
	self assert: aBounds bottom equals: 3.4 + 7.8.

	aBounds origin: 8.7 @ 6.5 extent: 4.3 @ 2.1.
	
	self assert: aBounds left equals: 8.7.
	self assert: aBounds top equals: 6.5.
	self assert: aBounds right equals: 8.7 + 4.3.
	self assert: aBounds bottom equals: 6.5 + 2.1
]

{ #category : #tests }
BlBoundsTest >> testScaleBy [

	| aBounds |
	aBounds := BlBounds origin: 1 @ 2 corner: 3 @ 4.
	aBounds scaleBy: 2.
	
	self assert: aBounds left equals: 2.
	self assert: aBounds top equals: 4.
	self assert: aBounds right equals: 6.
	self assert: aBounds bottom equals: 8.

	aBounds scaleBy: 1 / 2.
	
	self assert: aBounds left equals: 1.
	self assert: aBounds top equals: 2.
	self assert: aBounds right equals: 3.
	self assert: aBounds bottom equals: 4.

	aBounds scaleBy: 1.1 @ 2.2.
	
	self assert: aBounds left closeTo: 1.1.
	self assert: aBounds top closeTo: 4.4.
	self assert: aBounds right closeTo: 3.3.
	self assert: aBounds bottom closeTo: 8.8.

	aBounds scaleBy: 0.
	
	self assert: aBounds left equals: 0.
	self assert: aBounds top equals: 0.
	self assert: aBounds right equals: 0.
	self assert: aBounds bottom equals: 0
]

{ #category : #tests }
BlBoundsTest >> testTranslateBy [

	| aBounds |
	aBounds := BlBounds origin: 1 @ 2 corner: 3 @ 4.
	aBounds translateBy: 5 @ 15.
	
	self assert: aBounds left equals: 6.
	self assert: aBounds top equals: 17.
	self assert: aBounds right equals: 8.
	self assert: aBounds bottom equals: 19
]
