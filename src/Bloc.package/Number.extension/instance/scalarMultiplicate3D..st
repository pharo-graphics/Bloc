*Bloc
scalarMultiplicate3D: aVector3D
	"Perform a scalar multiplication of a given 3D vector by me"
	<return: #BlVector>

	^ BlVector
		x: aVector3D x * self
		y: aVector3D y * self
		z: aVector3D z * self