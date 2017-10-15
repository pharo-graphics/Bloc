printing
printOn: aStream
	aStream
		nextPut: $(;
		nextPutAll: self x asString;
		nextPutAll: ', ';
		nextPutAll: self y asString;
		nextPutAll: ', ';
		nextPutAll: self z asString;
		nextPutAll: ', ';
		nextPutAll: self w asString;
		nextPut: $)