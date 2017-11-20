adding
addSpan: aBrTextParagraphSpan
	spans add: aBrTextParagraphSpan.
	
	spans size = 1
		ifTrue: [ self spanAdded: spans first ]
		ifFalse: [ self spanAdded: spans last after: (spans at: spans size - 1) ]