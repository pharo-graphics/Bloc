*Bloc-Sparta
drawPathOnSpartaCanvas: aCanvas
	super drawPathOnSpartaCanvas: aCanvas.
	
	paragraph
		ifNil: [ ^ self ].

	paragraph renderOn: aCanvas