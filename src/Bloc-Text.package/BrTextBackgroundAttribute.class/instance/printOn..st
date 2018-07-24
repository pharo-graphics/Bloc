printing
printOn: aStream
	aStream
		nextPutAll: 'text-background: ';
		nextPutAll: self paint printString