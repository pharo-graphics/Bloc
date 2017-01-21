printing
printOn: aStream
	aStream nextPut: $(.
	aStream nextPutAll: 'Measurement mode: EXACT'.
	aStream nextPut: $)