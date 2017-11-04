*Bloc
scalarMultiplicate2D: aVector2D
	"Perform a scalar multiplication of a given 2D vector by me"
	<return: #BlVector>

	^ BlVector
		x: aVector2D x * self
		y: aVector2D y * self