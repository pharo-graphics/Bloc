physics
calculateTimeForScrolling: aDistance
	"Calculates the time it should take to scroll the given distance (in pixels)"
	<return: #Number>

	^ aDistance abs * self millisecondsPerPixel