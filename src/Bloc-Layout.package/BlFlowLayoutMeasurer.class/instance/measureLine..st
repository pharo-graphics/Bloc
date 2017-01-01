calculating
measureLine: aLine
	
	aLine children do: [ :aChild |
		| aRequestedExtent |
		aRequestedExtent := aChild width @ aChild height.
		aChild element measuredExtent = aRequestedExtent ifFalse: [ 
			aChild element measure: (BlExtentMeasurementSpec exact: aRequestedExtent) ] ]