printing
printOn: aStream
	aStream
		nextPutAll: misc label;
		nextPutAll: ' @ ';
		store: self identityHash