printing
printOn: aStream
	aStream
		nextPutAll: 'Event filter of ';
		nextPutAll: self eventClass name