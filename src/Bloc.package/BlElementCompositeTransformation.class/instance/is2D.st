testing
is2D
	"Return true if my current transformation is in 2D space, false otherwise"
	<return: #Boolean>
	
	^ self transformations allSatisfy: #is2D