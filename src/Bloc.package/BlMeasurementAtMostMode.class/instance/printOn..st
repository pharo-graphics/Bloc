printing
printOn: aStream
	aStream nextPut: $(.
	aStream nextPutAll: 'Measurement mode: AT MOST'.
	aStream nextPut: $)