physics
calculateTimeForScrolling: aDistance
	"Calculates the time it should take to scroll the given distance (in pixels)"
	<return: #Duration>

	^ self millisecondsPerPixel * aDistance abs