printing
printOn: aStream
	aStream
		nextPutAll: 'Line ';
		nextPutAll: self printAbsolute;
		nextPutAll: ' to '.
	self lineTo printOn: aStream