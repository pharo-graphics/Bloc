printing
printOn: aStream
	aStream
		nextPutAll: 'Event handler of ';
		nextPutAll: self eventClass name