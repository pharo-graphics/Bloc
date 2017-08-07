paragraph - geometry
spanAtIndex: anIndex
	<return: #BrTextparagraphSpan>
	
	self
		assert: [ self spans isNotEmpty ]
		description: [ 'There must be at least one span!' ].
		
	self
		assert: [ self text isNotEmpty or: [ anIndex isZero ] ]
		description: [ 'If text is empty index must be zero' ].
		
	self
		assert: [ self text isEmpty or: [ anIndex between: 0 and: self text size ] ]
		description: [ 'anIndex must be within text bounds (0 is allowed)' ].
	
	anIndex isZero
		ifTrue: [ ^ self spans first ].
		
	anIndex = self text size
		ifTrue: [ ^ self spans last ].

	^ self spans
		findBinary: [ :aParagraphSpan |
			(anIndex between: aParagraphSpan from and: aParagraphSpan to )
				ifTrue: [ 0 ]
				ifFalse: [ | spanCenter |
					spanCenter := aParagraphSpan from + ((aParagraphSpan to - aParagraphSpan from) // 2).
					anIndex < spanCenter
						ifTrue: [ -1 ]
						ifFalse: [ 1 ] ] ]
		ifNone: [ self error: 'Span for character at index ', anIndex asString, ' does not exist' ]