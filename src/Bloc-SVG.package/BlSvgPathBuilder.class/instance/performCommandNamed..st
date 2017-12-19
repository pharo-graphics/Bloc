commands
performCommandNamed: aSymbol
	self commands
		at: aSymbol
		ifPresent: [ :aCommand | aCommand value ]
		ifAbsent: [ self error: 'Invalid command - ', aSymbol asString ]