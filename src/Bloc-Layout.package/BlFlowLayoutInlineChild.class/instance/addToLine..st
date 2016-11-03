adding
addToLine: aLine
	
	(self orientation isHorizontal and: [ self direction isRightToLeft ])
		ifTrue: [ aLine addInlineFirst: self ]
		ifFalse: [ aLine addInlineLast: self ]