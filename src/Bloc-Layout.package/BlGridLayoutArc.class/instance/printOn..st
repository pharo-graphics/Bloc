as yet unclassified
printOn: aStream
	aStream
		nextPutAll: self span asString;
		nextPutAll: ' -> ';
		nextPutAll: self value asString;
		nextPutAll: ' : ';
		nextPutAll: self valid asString