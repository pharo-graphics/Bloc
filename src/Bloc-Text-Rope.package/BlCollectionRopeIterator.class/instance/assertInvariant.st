asserting
assertInvariant

	self
		assert: [ (start isZero and: [ end isZero and: [ position isZero ] ])
			or: [ start > 0 and: [ end > 0 and: [ start <= end and: [ position > 0 ] ] ] ] ]
		description: [ 'Start, end and position may only be zero at the same time,
			otherwise they all must be positive' ]