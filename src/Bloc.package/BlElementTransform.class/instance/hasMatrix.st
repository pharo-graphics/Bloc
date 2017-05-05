private
hasMatrix
	"Return true if any of 2D or 3D matrices exist, false otherwise.
	Note: I am useful for fast exits"
	<return: #Boolean>
	
	^ matrix2D isNotNil or: [ matrix3D isNotNil ]