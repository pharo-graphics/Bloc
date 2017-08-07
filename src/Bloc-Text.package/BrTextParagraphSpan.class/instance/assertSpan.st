asserting
assertSpan

	self
		assert: [ span isNotNil and: [ spanStart isNotNil and: [ spanEnd isNotNil ] ] ]
		description: [ 'Span is not initialized' ].
		
	self
		assert: [ span isNotEmpty or: [ spanStart isZero and: [ spanEnd isZero ] ] ]
		description: [ 'If span text is empty, start and end indices must be zero' ].
	
	self
		assert: [ span isEmpty or: [ spanStart between: 1 and: span size ] ]
		description: [ 'Span start must be within span bounds if it is not empty' ].
		
	self
		assert: [ span isEmpty or: [ spanEnd between: 1 and: span size ] ]
		description: [ 'Span end must be within span bounds if it is not empty' ].
		
	self
		assert: [ spanStart <= spanEnd ]
		description: [ 'Span start must be always smaller or equal to span end' ]