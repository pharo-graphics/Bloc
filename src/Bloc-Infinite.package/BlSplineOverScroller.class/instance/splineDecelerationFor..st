physics
splineDecelerationFor: aVelocity
	<return: #Number>

	^ ((Inflexion * aVelocity abs) / (flingFriction * physicalCoefficient)) ln