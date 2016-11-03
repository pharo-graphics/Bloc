instance creation
exact: anExtent
	^ self new
		widthSpec: (BlMeasurementSpec exact: anExtent x);
		heightSpec: (BlMeasurementSpec exact: anExtent y)