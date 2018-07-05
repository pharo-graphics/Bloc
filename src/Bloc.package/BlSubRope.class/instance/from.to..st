rope - accessing
from: aStart to: anEnd
	self assertAccess: aStart.
	self assertAccess: anEnd.
	
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	^ self rope from: offset + aStart to: offset + anEnd