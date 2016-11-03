printing
printOn: aStream
	aStream nextPut: $(.
	aStream nextPutAll: 'Measurement mode: AT MOST '.
	aStream nextPut: $(.
	aStream nextPutAll: self spec size asString.
	aStream nextPut: $).
	aStream nextPut: $)