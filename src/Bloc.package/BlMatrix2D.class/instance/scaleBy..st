matrix - transformations
scaleBy: aBlVector
	"Apply a scaling defined by a given vector"
	
	self
		assert: [ aBlVector z closeTo: 1 ]
		description: [ '2D Matrix is incompatible with 3D transformation' ].
		
	self postScaleX: aBlVector x Y: aBlVector y