printing
printOn: aStream
	aStream
		nextPutAll: 'before: ';
		nextPutAll: before asString;
		nextPutAll: ' after: ';
		nextPutAll: after asString;
		nextPutAll: ' size(false): ';
		nextPutAll: (self size: false) asString;
		nextPutAll: ' size(true): ';
		nextPutAll: (self size: true) asString