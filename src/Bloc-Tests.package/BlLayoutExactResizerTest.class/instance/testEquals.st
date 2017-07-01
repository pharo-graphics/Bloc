tests
testEquals
	
	self
		assert: (BlLayoutExactResizer zero)
		equals: (BlLayoutExactResizer zero).
	
	self
		assert: (BlLayoutExactResizer new size: 10)
		equals: (BlLayoutExactResizer new size: 10).

	self
		assert: (BlLayoutExactResizer new size: 10) ~= (BlLayoutExactResizer new size: 20).

	self
		assert: (BlLayoutExactResizer new size: 10) ~= (BlLayoutResizer fitContent).