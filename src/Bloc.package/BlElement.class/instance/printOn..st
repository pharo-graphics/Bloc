printing
printOn: aStream
	aStream
		nextPutAll: self className;
		nextPut: $@;
		store: self identityHash;
		nextPut: $(;
		"nextPutAll: 'pos:';
		print: self position;
		nextPutAll: ', geomBounds:';
		print: self geomBounds;
		nextPutAll: ', layoutBounds:';
		print: self layoutBounds;"
		nextPut: $)