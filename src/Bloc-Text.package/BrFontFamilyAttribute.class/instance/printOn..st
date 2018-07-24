printing
printOn: aStream
	aStream
		nextPutAll: 'font-family: ';
		nextPutAll: self name printString