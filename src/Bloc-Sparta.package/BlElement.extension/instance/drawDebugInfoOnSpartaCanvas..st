*Bloc-Sparta
drawDebugInfoOnSpartaCanvas: aCanvas
	| aWidth |

	aWidth := (self globalBoundsToLocal: (BlBounds origin: 0@0 extent: 1@1)) width.

	aCanvas stroke
		path: self geometryBounds;
		paint: (Color red alpha: 0.5);
		dashPattern: { aWidth * 6 . aWidth * 6 };
		width: aWidth;
		draw.

	aCanvas stroke
		path: self visualBounds;
		paint: (Color blue alpha: 0.5);
		width: aWidth;
		draw.
		
	aCanvas stroke
		path: self bounds inLocal asRectangle;
		paint: (Color gray alpha: 0.5);
		dashPattern: { aWidth * 6 . aWidth * 6 };
		width: aWidth;
		draw