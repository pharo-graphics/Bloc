drawing
drawOnSpartaCanvas: aCanvas
	self drawPathOnSpartaCanvas: aCanvas.
	layoutView := SpartaTextLayout rope: textModel rope.
	layoutView maxWidth: wrappingWidth.
	layoutView renderOn: aCanvas