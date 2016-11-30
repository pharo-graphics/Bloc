instance creation
obtain
	^ self pool acquire
		ifNil: [ self new ]