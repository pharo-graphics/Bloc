drawing
drawDebugInfoOnSpartaCanvas: aCanvas
	| aFont |

	super drawDebugInfoOnSpartaCanvas: aCanvas.
	
	aFont := aCanvas font
		size: 9;
		build.
	
	self decoratedAnchorPositions withIndexDo: [ :aPoint :anIndex |
		| anAnchorPosition |
		anAnchorPosition := self parentPointToLocal: aPoint.
		aCanvas stroke
			path: (aCanvas shape circleAt: anAnchorPosition radius: 10);
			width: 1;
			paint: Color gray;
			draw.
		
		aCanvas text
			string: anIndex asString;
			font: aFont;
			baseline: anAnchorPosition;
			draw.
		 ]