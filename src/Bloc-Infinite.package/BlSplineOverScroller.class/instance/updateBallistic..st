scrolling
updateBallistic: aDeltaTime
	"r = vt + at^2 / 2, r - distance, t - delta time, a - acceleration (constant)
	https://en.wikipedia.org/wiki/Acceleration#Uniform_acceleration"
	| aTime |

	aTime := aDeltaTime / 1000.0.
	currentVelocity := startVelocity + (deceleration * aTime).
	^ (startVelocity * aTime) + (deceleration * aTime * aTime / 2.0)