accessing
size: min
	^ (min not and: [ self canStretch ])
		ifTrue: [ self class maxSize ]
		ifFalse: [ before + after ]