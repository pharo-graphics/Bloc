printing
printOn: aStream
	super printOn: aStream.

	aStream
		space;
		nextPut: $(;
		nextPutAll: ((self progress * 100) roundTo: 0.01) asString;
		nextPut: $%;
		nextPut: $)