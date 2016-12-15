physics
splineFlingDurationFor: aVelocity
	"Return the duration, expressed in milliseconds"
	<return: #Number>
	| aSplineDeceleration |
	
	aSplineDeceleration := self splineDecelerationFor: aVelocity.
	^ 1000 * (aSplineDeceleration / ( DecelerationRate - 1 ) ) exp