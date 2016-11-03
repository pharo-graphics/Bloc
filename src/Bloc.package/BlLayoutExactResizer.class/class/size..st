accessing
size: aNumber
	aNumber isZero
		ifTrue: [ ^ self zero ].
		
	aNumber = 50
		ifTrue: [ ^ self fifty ].

	^ self new
		size: aNumber;
		yourself 