testing
hasHandler: anEventHandler
	^ handlers
		ifNil: [ false ]
		ifNotNil: [ handlers hasHandler: anEventHandler ]