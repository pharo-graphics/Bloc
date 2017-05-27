*Bloc-Sparta
drawOnSpartaCanvas: aCanvas
	super drawOnSpartaCanvas: aCanvas.
	
	paragraph
		ifNil: [ ^ self ].

	paragraph renderOn: aCanvas