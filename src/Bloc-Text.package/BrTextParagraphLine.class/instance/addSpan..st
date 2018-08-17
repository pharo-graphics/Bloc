adding
addSpan: aBrTextParagraphSpan
	spans add: aBrTextParagraphSpan.
	aBrTextParagraphSpan paragraph: self paragraph.

	spans size = 1
		ifTrue: [ self spanAdded: spans first ]
		ifFalse: [ self spanAdded: spans last after: (spans at: spans size - 1) ]