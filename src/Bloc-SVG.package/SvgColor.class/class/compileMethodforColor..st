initialize-release
compileMethodforColor: colorName
	|stream|
	stream := WriteStream with: colorName.
	stream nextPut: Character cr;
		nextPutAll: '	^ SVGColorRegistry at: #';
		nextPutAll: colorName.
	
	self class compile: stream contents classified: 'defaults'.