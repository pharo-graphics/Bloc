accessing
printOn: aStream
	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: self value asString;
		nextPut: $)