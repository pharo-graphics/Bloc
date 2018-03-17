printing
printOn: aStream
	aStream
		nextPutAll: self name;
		nextPut: Character space;
		nextPut: $(;
		nextPutAll: self size asString;
		nextPut: $)