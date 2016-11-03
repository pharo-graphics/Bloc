adding
addToLine: aLine
	
	"Only add me to the first line"
	self lines ifEmpty: [ 
		(self orientation isHorizontal and: [ self direction isRightToLeft ])
			ifTrue: [ aLine addFloatFirst: self ]
			ifFalse: [ aLine addFloatLast: self ] ].
	lines add: aLine