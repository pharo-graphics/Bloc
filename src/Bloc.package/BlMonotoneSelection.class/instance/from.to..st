initialization
from: aFromIndex to: aToIndex
	self
		assert: [ from isNil and: [ to isNil ] ]
		description: [ 'I am immutable and can not be changed' ].
	
	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'From index must not be greater than to index' ].

	from := aFromIndex.
	to := aToIndex.

	self assertInvariant