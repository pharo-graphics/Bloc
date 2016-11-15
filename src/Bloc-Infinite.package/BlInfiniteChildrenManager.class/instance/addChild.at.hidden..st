children add/remove
addChild: aChildElement at: index hidden: isHidden
	| offset |
	index <= 0
		ifTrue: [ offset := controller childrenCount ]
		ifFalse: [  offset := self computeOffset: index ].
	
	bucket insert: isHidden at: offset.
	
	isHidden ifTrue: [
		self hideChildInternal: aChildElement ].
	
	controller addChild: aChildElement at: offset