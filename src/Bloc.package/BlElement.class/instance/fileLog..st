debugging
fileLog: anObject
	(FileStream oldFileNamed: 'PharoDebug.log')
		setToEnd;
		nextPutAll: anObject asString;
		cr;
		flush;
		close