pool
release: anObject
	^ monitor critical: [ super release: anObject ]