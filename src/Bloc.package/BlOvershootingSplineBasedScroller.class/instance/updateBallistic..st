private - updating
updateBallistic: aDeltaTime
	"r = vt + at^2 / 2, r - distance, t - delta time, a - acceleration (constant)
	https://en.wikipedia.org/wiki/Acceleration#Uniform_acceleration"
	| aTimeInSeconds |

	aTimeInSeconds := aDeltaTime asMilliSeconds / 1000.0.
	
	self currentVelocity: startVelocity + (self deceleration * aTimeInSeconds).
	
	^ (startVelocity * aTimeInSeconds) + (self deceleration * aTimeInSeconds * aTimeInSeconds / 2.0)