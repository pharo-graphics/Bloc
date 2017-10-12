printing
printOn: aStream
	aStream
		nextPutAll: 'Rotation by ';
		nextPutAll: self angle asString;
		nextPutAll: ' degress around ';
		nextPutAll: self axis asString