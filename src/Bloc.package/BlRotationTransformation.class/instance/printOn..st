printing
printOn: aStream
	aStream
		nextPutAll: 'Rotation by ';
		nextPutAll: self angle asString;
		nextPutAll: ' degress around axis ';
		nextPutAll: self axis asString