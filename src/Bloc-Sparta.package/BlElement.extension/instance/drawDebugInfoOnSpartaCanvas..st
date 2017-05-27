*Bloc-Sparta
drawDebugInfoOnSpartaCanvas: aCanvas

	aCanvas stroke
		path: (self geometryBounds insetBy: 1);
		paint: Color red;
		strokeOptions: (aCanvas strokeOptions dashPattern: #(6 6));
		draw.

	aCanvas stroke
		path: (self visualBounds);
		paint: Color blue;
		draw.

	"aCanvas stroke
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
		draw."