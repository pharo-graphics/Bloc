tests
testHash

	self
		assert: (BlLayoutExactResizer new size: 10) hash
		equals: (BlLayoutExactResizer new size: 10) hash.