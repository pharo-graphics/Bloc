zooming
zoomReset
	zoomLevel := nil.
	self fitAll.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]