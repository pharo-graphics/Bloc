rope - accessing
attributes: anAttributesCollection from: aStart to: anEnd
	| leftSize newLeft newRight |
	self assertAccessInsert: aStart.
	self assertAccessInsert: anEnd.
	
	anAttributesCollection
		ifEmpty: [ ^ self ].

	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self class attributeRope
			attributes: anAttributesCollection
			rope: self ].

	leftSize := left size.
	newLeft := nil.
	newRight := nil.

	newLeft := anEnd <= leftSize
		ifTrue: [ left attributes: anAttributesCollection from: aStart to: anEnd ]
		ifFalse: [ aStart <= leftSize
			ifTrue: [ left attributes: anAttributesCollection from: aStart to: leftSize ]
			ifFalse: [ left ] ].

	newRight := aStart > leftSize
		ifTrue: [ right attributes: anAttributesCollection from: aStart - leftSize to: anEnd - leftSize ]
		ifFalse: [ anEnd > leftSize
			ifTrue: [ right attributes: anAttributesCollection from: 1 to: anEnd - leftSize ]
			ifFalse: [ right ] ].
		
	^ self class
		concatenate: newLeft
		and: newRight