printing
printOn: aStream
	aStream nextPut: $(.
	horizontal printOn: aStream.
	aStream nextPutAll: ', '.
	vertical printOn: aStream.
	aStream nextPut: $(.
	direction printOn: aStream.
	aStream nextPut: $).
	aStream nextPut: $)