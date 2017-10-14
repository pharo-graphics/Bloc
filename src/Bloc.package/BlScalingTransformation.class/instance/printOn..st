printing
printOn: aStream
	aStream
		nextPutAll: 'Scaling by '.
		
	self scale printOn: aStream