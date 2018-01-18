printing
printOn: aStream
	aStream nextPutAll: self type, ' event dispatcher for '.
	self owner printOn: aStream