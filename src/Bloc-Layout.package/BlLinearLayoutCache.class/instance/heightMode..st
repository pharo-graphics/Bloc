accessing
heightMode: aBlMeasurementMode
	self
		assert: [ aBlMeasurementMode isNotNil ]
		description: [ 'Height mode must not be nil' ].

	heightMode := aBlMeasurementMode