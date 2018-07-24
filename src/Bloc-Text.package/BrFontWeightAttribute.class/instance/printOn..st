printing
printOn: aStream
	aStream
		nextPutAll: 'font-weight: ';
		nextPutAll: self weight asString