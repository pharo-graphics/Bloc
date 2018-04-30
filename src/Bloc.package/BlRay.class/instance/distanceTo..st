vector functions
distanceTo: aPoint
	<return: #Number>
	
	self vector isZero
		ifTrue: [ ^ aPoint distanceTo: self point ].
	
	^ ((self vector y * aPoint x) - (self vector x * aPoint y) + (self point y * (self point x + self vector x)) - (self point x * (self point y + self vector y))) abs / self vector length