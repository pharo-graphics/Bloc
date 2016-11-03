drawing
drawOnSpartaCanvas: aCanvas
	self drawPathOnSpartaCanvas: aCanvas.
	layoutView renderOn: aCanvas
	