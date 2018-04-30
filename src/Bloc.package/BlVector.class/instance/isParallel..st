testing
isParallel: aBlVector
	<return: #Boolean>

	^ (self dotProduct: aBlVector) abs closeTo: 1