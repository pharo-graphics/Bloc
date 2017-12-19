printing
printOn: aStream
	aStream
		nextPutAll: 'Move ';
		nextPutAll: self printAbsolute;
		nextPutAll: ' to '.
	self moveTo printOn: aStream