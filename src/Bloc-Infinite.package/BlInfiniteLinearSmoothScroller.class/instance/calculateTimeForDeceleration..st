physics
calculateTimeForDeceleration: aDistance
	"Calculates the time for deceleration so that transition from LinearInterpolator to DecelerateInterpolator looks smooth.
	We want to cover same area with the linear interpolator for the first 10% of the interpolation.
	After that, deceleration will take control. Area under curve (1-(1-x)^2) can be calculated as (1 - x/3) * x * x
	which gives 0.100028 when x = 0.3356; this is why we divide linear scrolling time with 0.3356"
	<return: #Number>

	^ (self calculateTimeForScrolling: aDistance) / 0.3356