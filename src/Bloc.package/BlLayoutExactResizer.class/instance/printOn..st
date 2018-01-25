printing
printOn: aStream
	aStream
		nextPutAll: 'Exact ';
		nextPutAll: self size asString