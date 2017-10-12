printing
printOn: aStream
	aStream
		nextPut: $(;
		nextPutAll: self x asString;
		nextPut: $@;
		nextPutAll: self y asString;
		nextPut: $@;
		nextPutAll: self z asString;
		nextPut: $)