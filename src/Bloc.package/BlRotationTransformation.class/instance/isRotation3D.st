testing
isRotation3D
	"Return true if I represent a rotation in 3D space, false otherwise.
	By definition a rotation is in 3D when rotation axis differs from z-Axis (it has x or y components)"
	<return: #Boolean>
	
	^ self axis isAxisZ not