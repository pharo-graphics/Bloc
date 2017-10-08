testing
isRotation2D
	"Return true if I represent a rotation in 2D space, false otherwise.
	By definition a rotation is in 2D when rotation axis is z-Axis (it has no x or y components)"
	<return: #Boolean>
	
	^ self axis isAxisZ