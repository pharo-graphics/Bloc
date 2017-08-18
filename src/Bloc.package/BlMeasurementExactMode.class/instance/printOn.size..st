printing
printOn: aStream size: aNumber

	self printOn: aStream.	
	aStream nextPutAll: ' '.
	aStream nextPutAll: aNumber asString