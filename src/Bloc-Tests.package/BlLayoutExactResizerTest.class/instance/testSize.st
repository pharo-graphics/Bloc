tests
testSize
	| testResizer |
	
	testResizer := BlLayoutExactResizer new.
	testResizer size: 75.
	self assert: testResizer size equals: 75.
	
	testResizer := BlLayoutExactResizer new.
	testResizer size: 150.
	self assert: testResizer size equals: 150