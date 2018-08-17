testing
isScrollRight
	"We scroll to the right when direction vector has positive x component,
	because the content should move in the same direction as a hand on a touchpad.
	When hand is moved from left to right (right scroll) the content should moved by a positive delta"
	<return: #Boolean>

	^ vector x > 0