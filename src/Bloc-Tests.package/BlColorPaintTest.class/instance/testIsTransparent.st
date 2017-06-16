tests
testIsTransparent
	| paint |
	
	paint := BlColorPaint color: Color red.
	self assert: paint isTransparent not.
	
	paint := BlColorPaint color: (Color red alpha: 0.5).
	self assert: paint isTransparent not.
	
	paint := BlColorPaint color: (Color red alpha: 0).
	self assert: paint isTransparent.
	
	paint := BlColorPaint color: Color transparent.
	self assert: paint isTransparent.