printing
printOn: aStream

	aStream nextPut: $(.
	self events values
		do: [ :anEvent | aStream nextPutAll: anEvent key name asString ]
		separatedBy: [ aStream nextPutAll: ' ' ].
	aStream nextPut: $)