accessing
size: aNumber
	aNumber isZero
		ifTrue: [ ^ self zero ].
		
	aNumber = 50
		ifTrue: [ ^ self fifty ].
		
	aNumber = 100
		ifTrue: [ ^ self hundred ].

	^ self new
		size: aNumber;
		yourself 