accessing
textRun
	self
		assert: [ textRun isNull not ]
		description: [ 'Text run must not be nullptr' ].
	^ textRun