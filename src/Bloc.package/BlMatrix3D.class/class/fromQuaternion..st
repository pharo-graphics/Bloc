instance creation
fromQuaternion: aQuaternion
	"Return a new 3D rotation matrix from a given rotation quaternion"
	<return: #BlMatrix3D>

	^ self new
		quaternion: aQuaternion