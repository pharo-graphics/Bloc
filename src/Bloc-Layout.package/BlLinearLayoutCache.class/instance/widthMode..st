accessing
widthMode: aBlMeasurementMode
	self
		assert: [ aBlMeasurementMode isNotNil ]
		description: [ 'Height mode must not be nil' ].

	widthMode := aBlMeasurementMode