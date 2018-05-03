printing
storeOn: aStream
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' new'.
	aStream cr; tab.
	aStream nextPutAll: 'modifiers: '.
	aStream store: self modifiers.
	aStream nextPut: $;.
	aStream cr; tab.
	aStream nextPutAll: 'position: '.
	aStream nextPutAll: self position asString.
	aStream nextPut: $;.
	aStream cr; tab.
	aStream nextPutAll: 'screenPosition: '.
	aStream nextPutAll: self screenPosition asString.
	aStream nextPut: $;.
	aStream cr; tab.
	aStream nextPutAll: 'direction: '.
	aStream store: self direction.
	aStream nextPut: $;.
	aStream cr; tab.
	aStream nextPutAll: 'timestamp: ('.
	aStream nextPutAll: DateAndTime name.
	aStream nextPutAll: ' fromString: '''.
	aStream nextPutAll: self timestamp printString.
	aStream nextPutAll: ''')'.
	aStream nextPutAll: ')'