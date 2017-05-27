drawing
drawOnSpartaCanvas: aCanvas
	super drawOnSpartaCanvas: aCanvas.
	
	aCanvas stroke
		path: self geometryBounds;
		paint: Color green;
		width: 1;
		draw