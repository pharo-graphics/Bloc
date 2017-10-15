instance creation
rotation: aTheta axis: aVector
	"Create a 3D matrix representing a rotation about a given axis vector
	by aTheta radians"
	<return: #BlMatrix3D>
	
	^ self new
		rotation: aTheta axis: aVector