instance creation
fill: aColorOrPaint
	^ super new
		fill: aColorOrPaint asBlPaint image: nil outsets: nil;
		yourself