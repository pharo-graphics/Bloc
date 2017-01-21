accessing
unspecified
	<return: #BlMeasurementMode>
	
	^ unspecified ifNil: [ unspecified := BlMeasurementUnspecifiedMode new ]