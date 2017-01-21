accessing
exact
	<return: #BlMeasurementMode>
	
	^ exact ifNil: [ exact := BlMeasurementExactMode new ]