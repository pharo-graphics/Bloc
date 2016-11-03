printing
printOn: aStream
	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: 'name:';
		nextPutAll: self name;
		nextPutAll: ', value:';
		print: self rawValue;
		nextPut: $)