accessing
zoomLevel: aNumber
	zoomLevel := aNumber.
	self fixed: zoomLevel.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]