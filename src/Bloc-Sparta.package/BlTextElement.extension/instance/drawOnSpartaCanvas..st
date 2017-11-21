*Bloc-Sparta
drawOnSpartaCanvas: aCanvas
	super drawOnSpartaCanvas: aCanvas.
	
	paragraph
		ifNil: [ ^ self ].

	paragraph selection: self selection.
	paragraph containerExtent: self extent.
	
	aCanvas transform
		during: [ :aTransform |
			aTransform translateBy: self padding topLeft.
			aTransform apply.
			paragraph drawOn: aCanvas ]