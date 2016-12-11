instance creation
fromValue: aNumber
	^ self new
		initializeWith: aNumber;
		yourself