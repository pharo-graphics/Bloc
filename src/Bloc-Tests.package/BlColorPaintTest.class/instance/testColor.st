tests
testColor
	| paint |
	
	paint := BlColorPaint color: Color red.
	self assert: paint color equals: Color red.
	
	paint := BlColorPaint new color: Color blue.
	self assert: paint color equals: Color blue