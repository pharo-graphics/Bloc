layout
onMeasure: anExtentMeasurementSpec
	self relocate: (overlayListener positionFor: referenceElement).
	self size: (overlayListener extentFor: referenceElement).

	super onMeasure: anExtentMeasurementSpec