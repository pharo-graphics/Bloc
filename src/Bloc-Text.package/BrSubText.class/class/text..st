instance creation
text: aBrText
	self
		assert: [ (aBrText isKindOf: self) not ]
		description: [ 'Can not create sub text of a subtext' ].

	^ self new
		text: aBrText from: 1 to: aBrText size;
		yourself