private utilities
adjust: aMeasurementSpec by: delta

	^ BlMeasurementSpec new
		size: (aMeasurementSpec size ifNotNil: [ :size | size + delta ]);
		mode: aMeasurementSpec mode