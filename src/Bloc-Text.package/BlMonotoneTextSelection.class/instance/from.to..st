initialization
from: aFromIndex to: aToIndex
	self
		assert: [ from isNil and: [ to isNil ] ]
		description: [ 'I am immutable and can not be changed' ].
	
	from := aFromIndex.
	to := aToIndex.

	self assertInvariant