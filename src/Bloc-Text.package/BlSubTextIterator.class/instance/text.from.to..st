initialization
text: aBrSubText from: aStartIndex to: anEndIndex
	
	self
		assert: [ aStartIndex isInteger and: [ anEndIndex isInteger ] ]
		description: [ 'Only integers are alowed as start and end indices' ].
	self
		assert: [ aBrSubText isNotNil ]
		description: [ 'Text must not be nil' ].
	self
		assert: [ aStartIndex between: 0 and: aBrSubText size ]
		description: [ 'Sub-text start index is out of bounds!' ].
	self
		assert: [ anEndIndex between: 0 and: aBrSubText size ]
		description: [ 'Sub-text end index is out of bounds!' ].
	self
		assert: [ aBrSubText isNotEmpty or: [ aStartIndex isZero and: [ anEndIndex isZero ] ] ]
		description: [ 'If text is empty, start and end indices must be Zero!' ].
	self
		assert: [ aStartIndex isZero not or: [ anEndIndex isZero ] ]
		description: [ 'If start index is zero then end index must also be zero' ].
	self
		assert: [ anEndIndex isZero not or: [ aStartIndex isZero ] ]
		description: [ 'If end index is zero then start index must also be zero' ].
		
	
	text := aBrSubText.
	
	iterator := aBrSubText text
		iterator: ((aStartIndex + text start - 1) max: 0)
		to: ((anEndIndex + text start - 1) max: 0)