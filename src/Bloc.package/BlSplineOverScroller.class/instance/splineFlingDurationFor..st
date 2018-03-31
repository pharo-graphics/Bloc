physics
splineFlingDurationFor: aVelocity
	"Return the duration, expressed in milliseconds"
	<return: #Duration>
	| aSplineDeceleration |
	
	aSplineDeceleration := self splineDecelerationFor: aVelocity.
	"we explicitely truncate, not round to be in sync with original implementation of the algorithm"
	^ (self truncated: (1000.0 * (aSplineDeceleration / ( DecelerationRate - 1 ) ) exp)) milliSeconds