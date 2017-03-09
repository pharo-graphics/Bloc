*Bloc-Sparta
drawOnSpartaCanvas: aCanvas
	super drawOnSpartaCanvas: aCanvas.
	
	textLayout
		ifNil: [ ^ self ].

	textLayout renderOn: aCanvas