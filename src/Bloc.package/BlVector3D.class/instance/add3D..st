arithmetic
add3D: aVector3D
	"Add me to a given 3D vector"
	<return: #BlVector>

	^ self class
		x: aVector3D x + self x
		y: aVector3D y + self y
		z: aVector3D z + self z