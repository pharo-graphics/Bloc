asserting
assertInvariant
	self
		assert: [ start isInteger and: [ end isInteger ] ]
		description: [ 'Only integers are alowed as start and end indices' ].
	self
		assert: [ text isNotNil ]
		description: [ 'Text must not be nil' ].
	self
		assert: [ start between: 0 and: text size ]
		description: [ 'Sub-text start index is out of bounds!' ].
	self
		assert: [ end between: 0 and: text size ]
		description: [ 'Sub-text end index is out of bounds!' ].
	self
		assert: [ text isNotEmpty or: [ start isZero and: [ end isZero ] ] ]
		description: [ 'If text is empty, start and end indices must be Zero!' ].
	self
		assert: [ start isZero not or: [ end isZero ] ]
		description: [ 'If start index is zero then end index must also be zero' ].
	self
		assert: [ end isZero not or: [ start isZero ] ]
		description: [ 'If end index is zero then start index must also be zero' ]