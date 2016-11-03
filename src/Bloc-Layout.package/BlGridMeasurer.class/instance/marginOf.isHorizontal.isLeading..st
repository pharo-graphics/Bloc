margin
marginOf: aChildElement isHorizontal: isHorizontal isLeading: isLeading
	| margin |

	margin := isHorizontal
		ifTrue: [ isLeading ifTrue: [ aChildElement margin left ] ifFalse: [ aChildElement margin right ] ]
		ifFalse: [ isLeading ifTrue: [ aChildElement margin top ] ifFalse: [ aChildElement margin bottom ] ].

	^ margin < 0
		ifTrue: [ self cellSpacingOf: aChildElement isHorizontal: isHorizontal isLeading: isLeading ]
		ifFalse: [ margin ]