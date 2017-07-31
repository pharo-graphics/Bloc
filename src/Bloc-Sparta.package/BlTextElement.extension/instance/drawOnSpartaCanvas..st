*Bloc-Sparta
drawOnSpartaCanvas: aCanvas
	super drawOnSpartaCanvas: aCanvas.
	
	paragraph
		ifNil: [ ^ self ].

	paragraph selection: self selection.
	paragraph containerExtent: self extent.
	paragraph renderOn: aCanvas