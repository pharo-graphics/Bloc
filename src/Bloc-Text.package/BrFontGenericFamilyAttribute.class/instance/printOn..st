printing
printOn: aStream
	aStream
		nextPutAll: 'font-family: ';
		nextPutAll: self family