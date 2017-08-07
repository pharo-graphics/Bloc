text - accessing
from: aStart to: anEnd
	self assertInvariant.
	
	self
		assert: [ self isNotEmpty or: [ aStart isZero and: [ anEnd isZero ] ] ]
		description: [ 'If I am empty both start and end must be zero' ].
	
	^ self text
		from: ((aStart + start - 1) max: 0)
		to: ((anEnd + start - 1) max: 0)