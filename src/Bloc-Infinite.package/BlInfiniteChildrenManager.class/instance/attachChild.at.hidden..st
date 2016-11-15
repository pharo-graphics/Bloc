children add/remove
attachChild: child at: index hidden: isHidden
	| offset |
	
	index <= 0
		ifTrue: [ offset := controller childrenCount ]
		ifFalse: [ offset := self computeOffset: index ].
	
	bucket insert: isHidden at: offset.

	isHidden
		ifTrue: [ self hideChildInternal: child ].
	
	controller attachChild: child at: offset