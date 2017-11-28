layout
onMeasure: anExtentMeasurementSpec.
	self layout measureIgnored: self with: anExtentMeasurementSpec.
	super onMeasure: anExtentMeasurementSpec.
	self measureHeads.