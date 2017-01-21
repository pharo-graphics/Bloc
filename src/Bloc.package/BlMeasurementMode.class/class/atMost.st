accessing
atMost
	<return: #BlMeasurementMode>

	^ atMost ifNil: [ atMost := BlMeasurementAtMostMode new ]