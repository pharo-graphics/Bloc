printing
printOn: aStream
	aStream
		nextPutAll: 'font-size: ';
		nextPutAll: self size asString