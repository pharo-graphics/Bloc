adding
addSpan: aBrTextParagraphSpan
	spans add: aBrTextParagraphSpan.
	
	spans size = 1
		ifTrue: [ self firstSpanAdded ]
		ifFalse: [ self lastSpanAdded ]