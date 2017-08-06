asserting
assertTextRun

	self
		assert: [ textRun isNotNil and: [ textRunStart isNotNil and: [ textRunEnd isNotNil ] ] ]
		description: [ 'Text run is not initialized' ].