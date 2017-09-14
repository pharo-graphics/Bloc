skewing
skewX: aX Y: aY Z: aZ
	(aX isZero and: [ aY isZero and: [ aZ isZero ] ])
		ifTrue: [ ^ self ].
	self setSkewX: aX Y: aY Z: aZ