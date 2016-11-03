accessing
extent: aPoint
	
	self constraintsDo: [ :lp | 
		(self width = aPoint x) ifFalse:[lp horizontal exact: aPoint x] .
		(self height = aPoint y) ifFalse:[lp vertical exact: aPoint y]].
	self extentProperty value: aPoint.