rope - accessing
from: aStart to: anEnd
	| leftSize |

	self assertAccessInsert: aStart.
	self assertAccessInsert: anEnd.

	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	leftSize := left size.
	anEnd <= leftSize
		ifTrue: [ ^ left from: aStart to: anEnd ].

	aStart > leftSize
		ifTrue: [ ^ right from: aStart - leftSize to: anEnd - leftSize ].

	^ self class 
		concatenate: (left from: aStart to: leftSize)
		and: (right from: 1 to: anEnd - leftSize)