initialization
initialize
	super initialize.
	
	cellSpacing := self defaultCellSpacing.
	alignmentMode := self defaultAlignmentMode.
	orientation := self defaultOrientation.
	verticalAxis := BlGridLayoutAxis new horizontal: false.
	horizontalAxis := BlGridLayoutAxis new horizontal: true.
	measurer := self defaultMeasurer