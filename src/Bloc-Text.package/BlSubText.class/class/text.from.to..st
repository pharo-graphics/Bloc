instance creation
text: aBrText from: aStartIndex to: anEndIndex
	self
		assert: [ (aBrText isKindOf: self) not ]
		description: [ 'Can not create sub text of a subtext' ].

	^ self new
		text: aBrText from: aStartIndex to: anEndIndex;
		yourself