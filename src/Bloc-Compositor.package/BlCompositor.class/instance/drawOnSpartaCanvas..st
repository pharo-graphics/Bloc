drawing
drawOnSpartaCanvas: aCanvas
	| elevationTree |
	
	elevationTree := self buildElevationTree: rootElement.
	elevationTree drawOnSpartaCanvas: aCanvas