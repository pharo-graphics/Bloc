calculating
measureLine: aLine
	
	aLine children do: [ :aChild |
		aChild element measure: (BlExtentMeasurementSpec exact: aChild width @ aChild height) ]