measurement
onMeasure: anExtentMeasurementSpec
	layout shouldAutoMeasure
		ifTrue: [ self onMeasureAuto: anExtentMeasurementSpec ]
		ifFalse: [ self onMeasureCustom: anExtentMeasurementSpec ]