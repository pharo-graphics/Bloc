computation
computeMatrix	
	self transformations
		"when composing transformations we should perform left multiplication.
		since multiplyBy: is a right multiplication we should iterate in reversed order"
		reverseDo: [ :anElementTransformation | matrix multiplyBy: anElementTransformation matrix ]