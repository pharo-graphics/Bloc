private - physics
splineDecelerationFor: aVelocity
	<return: #Number>

	^ ((self inflexion * aVelocity abs) / (self friction * self physicalCoefficient)) ln