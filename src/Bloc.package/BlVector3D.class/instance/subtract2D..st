arithmetic
subtract2D: aVector2D
	"Substruct me from a given 2D vector"
	<return: #BlVector>

	^ self class
		x: aVector2D x - self x
		y: aVector2D y - self y
		z: self z negated