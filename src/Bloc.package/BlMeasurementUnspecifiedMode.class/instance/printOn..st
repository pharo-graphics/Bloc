printing
printOn: aStream
	aStream nextPut: $(.
	aStream nextPutAll: 'Measurement mode: UNSPECIFIED'.
	aStream nextPut: $)