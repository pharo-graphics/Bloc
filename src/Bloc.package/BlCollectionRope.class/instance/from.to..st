rope - accessing
from: aStart to: anEnd
	| aNewLegnth |
	self assertAccessFrom: aStart to: anEnd.

	(aStart isZero and: [ anEnd isZero ])
		ifTrue: [ ^ self empty ].

	"return this very rope if the requested sub-rope interval exactly matches myself"
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	aNewLegnth := anEnd - aStart + 1.

	^ (aNewLegnth <= self class combineLength)
		ifTrue: [ self class collection: (collection copyFrom: aStart to: anEnd) ]
		ifFalse: [ self class subRope rope: self offset: aStart - 1 length: aNewLegnth ]