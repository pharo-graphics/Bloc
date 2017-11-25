layout
onMeasure: anExtentMeasurementSpec
	self measureGeometry.
	
	self invalidate.
	pathCache releaseCache.

	super onMeasure: anExtentMeasurementSpec