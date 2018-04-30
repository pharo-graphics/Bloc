printing
printOn: aStream
	aStream
		print: self point;
		nextPutAll: ' -> ';
		print: self vector