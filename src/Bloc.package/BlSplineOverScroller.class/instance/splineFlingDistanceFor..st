physics
splineFlingDistanceFor: aVelocity
	<return: #Number>
	| aSplineDeceleration |

	aSplineDeceleration := self splineDecelerationFor: aVelocity.
	^ (self friction * self physicalCoefficient * (self decelerationRate / (self decelerationRate - 1) * aSplineDeceleration ) exp)