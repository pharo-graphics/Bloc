private - assertions
assertInLayoutOrScroll
	"Checks if InfiniteElement is in the middle of a layout or scroll
	and throws an assertion error if it is not"
	
	self
		assert: [ self isComputingLayout ]
		description: [ 'InfiniteElement is not computing a layout or scrolling while it should' ].