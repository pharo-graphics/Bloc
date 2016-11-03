initialization
initialize
	super initialize.

	verticalAxis := BlGridLayoutAxis new horizontal: false.
	horizontalAxis := BlGridLayoutAxis new horizontal: true.
	measurer := self defaultMeasurer