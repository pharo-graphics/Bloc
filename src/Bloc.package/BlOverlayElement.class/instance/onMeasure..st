layout
onMeasure: anExtentMeasurementSpec

	self isAttached
		ifTrue: [ self measureMyBounds ].

	super onMeasure: anExtentMeasurementSpec