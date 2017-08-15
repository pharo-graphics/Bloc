printing
printOn: aStream
	aStream
		nextPut: $(;
		nextPutAll: self elevation asString;
		nextPut: $)