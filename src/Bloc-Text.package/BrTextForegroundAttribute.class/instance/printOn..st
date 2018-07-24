printing
printOn: aStream
	aStream
		nextPutAll: 'text-foreground: ';
		nextPutAll: self paint printString