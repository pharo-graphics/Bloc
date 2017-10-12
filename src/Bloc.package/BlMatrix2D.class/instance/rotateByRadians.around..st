matrix - transformations
rotateByRadians: aNumber around: aBlVector
	"Apply a rotation transformation by a given amount of radians around a provided axis vector"
	
	self
		assert: [ aBlVector isAxisZ ]
		description: [ '2D Matrix is incompatible with 3D transformation' ].
		
	self postRotate: aNumber