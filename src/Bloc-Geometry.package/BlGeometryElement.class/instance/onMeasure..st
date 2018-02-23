layout
onMeasure: anExtentMeasurementSpec
	self measureGeometry.
	
	self invalidate.
	self geometry releaseCache.

	super onMeasure: anExtentMeasurementSpec