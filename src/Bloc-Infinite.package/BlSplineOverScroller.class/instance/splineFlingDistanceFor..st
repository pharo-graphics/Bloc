physics
splineFlingDistanceFor: aVelocity
	<return: #Number>
	| aSplineDeceleration |
	
	aSplineDeceleration := self splineDecelerationFor: aVelocity.
	^ (flingFriction * physicalCoefficient * ( DecelerationRate / (DecelerationRate - 1) * aSplineDeceleration ) exp)