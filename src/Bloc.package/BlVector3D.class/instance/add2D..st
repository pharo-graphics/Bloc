arithmetic
add2D: aVector2D
	"Add me from a given 2D vector"
	<return: #BlVector>

	^ self class
		x: aVector2D x + self x
		y: aVector2D y + self y
		z: self z