printing
printOn: aStream
	aStream nextPut: $[.
	aStream nextPutAll: self from asString.
	aStream nextPutAll: ','.
	aStream nextPutAll: self to asString.
	aStream nextPut: $].