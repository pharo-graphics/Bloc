printing
printOn: aStream
	aStream nextPutAll: 'width: ('.
	aStream nextPutAll: (self widthSpec asString).
	aStream nextPutAll: ') height: ('.
	aStream nextPutAll: (self heightSpec asString).
	aStream nextPutAll: ')'.