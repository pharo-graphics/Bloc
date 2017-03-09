rope - accessing
clearAttributes: aStart to: anEnd if: aBlock
	| leftSize newLeft newRight |
	self assertAccessInsert: aStart.
	self assertAccessInsert: anEnd.
	

	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self class
			concatenate: (left clearAttributes: 1 to: left size if: aBlock)
			and: (right clearAttributes: 1 to: right size if: aBlock) ].

	leftSize := left size.
	newLeft := nil.
	newRight := nil.

	newLeft := anEnd <= leftSize
		ifTrue: [ left clearAttributes: aStart to: anEnd if: aBlock ]
		ifFalse: [ aStart <= leftSize
			ifTrue: [ left clearAttributes: aStart to: leftSize if: aBlock ]
			ifFalse: [ left ] ].

	newRight := aStart > leftSize
		ifTrue: [ right clearAttributes: aStart - leftSize to: anEnd - leftSize if: aBlock ]
		ifFalse: [ anEnd > leftSize
			ifTrue: [ right clearAttributes: 1 to: anEnd - leftSize if: aBlock ]
			ifFalse: [ right ] ].

	^ self class
		concatenate: newLeft
		and: newRight