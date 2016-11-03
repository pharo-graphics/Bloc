printing
printOn: aStream
	aStream nextPut: $(.
	aStream nextPutAll: 'Measurement mode: EXACT '.
	aStream nextPut: $(.
	aStream nextPutAll: self spec size asString.
	aStream nextPut: $).
	aStream nextPut: $)