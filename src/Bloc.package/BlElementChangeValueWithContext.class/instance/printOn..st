printing
printOn: aStream
	super printOn: aStream.
	
	aStream
		nextPutAll: ' | (';
		nextPutAll: self context asString;
		nextPutAll: ')';
		nextPutAll: ' | (';
		nextPutAll: timestamp asString;
		nextPutAll: ')'