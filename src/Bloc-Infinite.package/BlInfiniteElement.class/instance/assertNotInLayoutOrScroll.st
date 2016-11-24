private - assertions
assertNotInLayoutOrScroll
	"Checks if InfiniteElement is in the middle of a layout or scroll
	and throws an assertion error if it is"
	
	self
		assert: [ self isComputingLayout not ]
		description: [ 'InfiniteElement is computing a layout or scrolling while it should not' ].
	
	self
		assert: [ dispatchScrollCounter isZero ]
		description: [ 'Can not change the structure of InfiniteElement during scrolling' ]