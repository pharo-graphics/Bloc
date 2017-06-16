rendering
morphFrom: aSpartaPresentation
	| canvas |
	
	canvas := aSpartaPresentation canvas extent: aSpartaPresentation extent.
	aSpartaPresentation drawBlock value: canvas.
	
	^ canvas asForm asMorph