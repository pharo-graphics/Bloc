matrix - transformations
translateBy: aBlVector
	"Apply a translation by a given vector"
	
	self
		assert: [ aBlVector hasComponentZ not ]
		description: [ '2D Matrix is incompatible with 3D transformation' ].
		
	self postTranslateX: aBlVector x Y: aBlVector y