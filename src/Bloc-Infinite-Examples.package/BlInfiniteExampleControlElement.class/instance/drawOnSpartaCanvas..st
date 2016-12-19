drawing
drawOnSpartaCanvas: aCanvas
	| aTextPainter aFont aBounds aBaseline |
	super drawOnSpartaCanvas: aCanvas.
	
	aFont := aCanvas font
		sansSerif;
		size: self fontSize;
		build.
	
	aTextPainter := aCanvas text
		string: self label;
		font: aFont;
		yourself.

	aBounds := aTextPainter measure textMetrics boundingBox.
	
	aBaseline := (aBounds origin negated) + (((self width - aBounds width) @ (self height - aBounds height)) / 2).
	
	aTextPainter
		baseline: aBaseline;
		draw