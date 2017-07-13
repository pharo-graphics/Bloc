rope - accessing
from: aStart to: anEnd
	self assertAccess: aStart.
	self assertAccess: anEnd.
	
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	^ self class attributeRope
		attributes: attributes
		rope: (rope from: aStart to: anEnd)