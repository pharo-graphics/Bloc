testing
isVisible
	"Return true if I am visible and should be rendered, false otherwise.
	Note: Non-zero border with transparent paint is still needs to be rendered,
	since it removes an overlapping background area"
	<return: #Boolean>

	^ width isZero not