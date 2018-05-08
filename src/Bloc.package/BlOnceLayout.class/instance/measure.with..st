measure
measure: anElement with: anExtentSpec
	self isStopped
		ifTrue: [ ^ super measure: anElement with: (BlExtentMeasurementSpec exact: measuredExtent) ].
	self layout measure: anElement with: anExtentSpec