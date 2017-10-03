printing
gtDisplayOn: aStream
	super gtDisplayOn: aStream.
	
	aStream
		nextPutAll: ' | (';
		nextPutAll: self context asString;
		nextPutAll: ')';
		nextPutAll: ' | (';
		nextPutAll: timestamp asString;
		nextPutAll: ')'