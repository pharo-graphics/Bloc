rope - accessing
from: aStart to: anEnd
	self assertAccess: aStart.
	self assertAccess: anEnd.

	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	^ (anEnd - aStart + 1 <= self class combineLength)
		ifTrue: [ self class collectionRope collection: (collection copyFrom: aStart to: anEnd) ]
		ifFalse: [ self class subRope rope: self offset: aStart - 1 length: anEnd - aStart + 1 ]