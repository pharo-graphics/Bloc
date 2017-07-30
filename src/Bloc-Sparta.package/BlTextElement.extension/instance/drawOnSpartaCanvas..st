*Bloc-Sparta
drawOnSpartaCanvas: aCanvas
	super drawOnSpartaCanvas: aCanvas.
	
	paragraph
		ifNil: [ ^ self ].

	paragraph selection: self selection.
	paragraph renderOn: aCanvas