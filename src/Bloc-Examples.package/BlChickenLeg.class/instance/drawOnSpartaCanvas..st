drawing
drawOnSpartaCanvas: aCanvas
	| aLegPath |
	super drawOnSpartaCanvas: aCanvas.

	aLegPath := aCanvas path
		relative;
		moveTo: (self width / 2) asFloat @ 0;
		lineTo: 0 @ (self height * 2 / 3) asFloat;
		lineTo: self width / 2 * 1.25 negated asFloat @ (self height / 3) asFloat;
		moveTo: (self width / 2 * 1.25 negated asFloat  @ (self height / 3) asFloat) negated;
		lineTo: (self width / 2 * 1.25) asFloat  @ (self height / 3) asFloat ;
		finish.
		
	aCanvas stroke
		path: aLegPath;
		paint: Color red;
		width: 2;
		draw.