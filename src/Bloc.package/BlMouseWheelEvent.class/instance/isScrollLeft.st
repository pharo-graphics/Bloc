testing
isScrollLeft
	"We scroll to the left when direction vector has negative x component,
	because the content should move in the same direction as a hand on a touchpad.
	When hand is moved from right to left (left scroll) the content should moved by a negative delta"
	<return: #Boolean>

	^ vector x < 0