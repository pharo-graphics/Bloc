printing
printOn: aStream
	aStream
		nextPutAll: 'Translation by '.
		
	self translation printOn: aStream