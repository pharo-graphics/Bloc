drawing
drawPathOnSpartaCanvas: aCanvas
	super drawPathOnSpartaCanvas: aCanvas.
	
	aCanvas stroke
		path: self geometryBounds;
		paint: Color green;
		width: 1;
		draw