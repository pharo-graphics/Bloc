testing
is3D
	"Return true if my current transformation is in 3D space, false otherwise"
	<return: #Boolean>

	^ translateZ ~= 0.0 or:[scaleZ ~= 1.0]