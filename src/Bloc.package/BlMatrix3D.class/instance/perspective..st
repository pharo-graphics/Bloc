matrix - transformations
perspective: aDepth
	"Apply perspective by aDepth which should be positive"
	
	self
		assert: [ aDepth > 0 ]
		description: [ 'Perspective must be positive' ].
	
	shx1 := shx1 - (1.0 / aDepth * x).
	shy1 := shy1 - (1.0 / aDepth * y).
	sz := sz - (1.0 / aDepth * z).
	wz := wz - (1.0 / aDepth * w)