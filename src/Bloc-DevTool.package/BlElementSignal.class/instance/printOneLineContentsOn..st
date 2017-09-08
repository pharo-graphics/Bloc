printing
printOneLineContentsOn: stream
	stream 
		nextPutAll: self element asString;
		space;
		nextPutAll: self globalPosition asString;
		space;
		nextPutAll: self position asString;
		space;
		nextPutAll: self extent asString.