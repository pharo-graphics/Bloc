comparing
< aPoint
	"Answer whether the receiver is above and to the left of aPoint."
	<return: #Boolean>

	^ x < aPoint x and: [ y < aPoint y ]