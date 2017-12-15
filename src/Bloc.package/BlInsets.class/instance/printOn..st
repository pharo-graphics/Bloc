printing
printOn: aStream
	super printOn: aStream.
	aStream
		nextPutAll: ' top: ';
		print: top;
		nextPutAll: ' right: ';
		print: right;
		nextPutAll: ' bottom: ';
		print: bottom;
		nextPutAll: ' left: ';
		print: left