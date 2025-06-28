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
