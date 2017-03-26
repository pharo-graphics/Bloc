cursor - management
moveCursor: aCursorElement to: aTextIndex in: aTextElement
	| aTextPosition aParagraphSpan |
	
	self
		assert: [ aTextIndex >= 0 ]
		description: [ 'Text index must not be negative' ].
		
	self
		assert: [ aTextIndex <= aTextElement text size ]
		description: [ 'Text index must be within text size' ].

	aTextIndex = aCursorElement textIndex
		ifTrue: [ ^ self ].
	
	aParagraphSpan := aTextElement paragraph spanAtIndex: aTextIndex.
	aTextPosition := aParagraphSpan positionAt: aTextIndex.
	
	aCursorElement size: 2 @ aParagraphSpan height.
	aCursorElement position: (aTextPosition - (2 @ aParagraphSpan height / 2.0)).
	aCursorElement textIndex: aTextIndex