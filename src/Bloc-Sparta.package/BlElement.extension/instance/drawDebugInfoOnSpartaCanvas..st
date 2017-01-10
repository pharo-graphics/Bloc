*Bloc-Sparta
drawDebugInfoOnSpartaCanvas: aCanvas
	aCanvas stroke
		path: (self boundsInLocal insetBy: 1);
		paint: Color red;
		draw.

	aCanvas stroke
		path: (self effectBounds insetBy: 1);
		paint: Color blue;
		draw.

	aCanvas stroke
		path: (self transformedBounds insetBy: 1);
		paint: Color yellow;
		draw.