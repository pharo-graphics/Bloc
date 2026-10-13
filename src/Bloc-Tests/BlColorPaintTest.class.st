Class {
	#name : #BlColorPaintTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Paint'
}

{ #category : #tests }
BlColorPaintTest >> testColor [

	| paint |
	paint := BlColorPaint color: Color red.
	self assert: paint color equals: Color red.

	paint := BlColorPaint color: Color blue.
	self assert: paint color equals: Color blue
]

{ #category : #tests }
BlColorPaintTest >> testIsTransparent [

	| paint |
	paint := BlColorPaint color: Color red.
	self assert: paint isTransparent not.

	paint := BlColorPaint color: (Color red alpha: 0.5).
	self assert: paint isTransparent not.

	paint := BlColorPaint color: (Color red alpha: 0).
	self assert: paint isTransparent.

	paint := BlColorPaint color: Color transparent.
	self assert: paint isTransparent
]

{ #category : #tests }
BlColorPaintTest >> testTransparent [

	| paint |
	paint := BlColorPaint transparent.
	self assert: paint color equals: Color transparent.
	self assert: paint isTransparent.
	self deny: paint isOpaque.
	self assert: paint equals: (BlColorPaint color: Color transparent).
	self assert: paint equals: Color transparent asBlPaint.
	self assert: paint equals: BlPaint transparent.
	self assert: paint hash equals: (BlColorPaint color: Color transparent) hash
]
