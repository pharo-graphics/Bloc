rope - accessing
from: aStart to: anEnd
	self assertAccessInsert: aStart.
	self assertAccessInsert: anEnd.
	
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	^ self class attributeRope
		attributes: attributes
		rope: (rope from: aStart to: anEnd)