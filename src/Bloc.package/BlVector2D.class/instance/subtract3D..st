arithmetic
subtract3D: aVector3D
	"Substruct me from a given 3D vector"
	<return: #BlVector>

	^ self class
		x: aVector3D x - self x
		y: aVector3D y - self y
		z: aVector3D z