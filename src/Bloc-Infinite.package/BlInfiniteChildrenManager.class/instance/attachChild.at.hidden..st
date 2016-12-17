children add/remove
attachChild: aChildElement at: anIndex hidden: isHidden
	"Attaches aChildElement to the infinite element"

	| offset |
	
	anIndex <= 0
		ifTrue: [ offset := controller childrenCount + 1 ]
		ifFalse: [ offset := (self computeOffset: anIndex) + 1 ].
	
	bucket insert: isHidden at: offset.

	isHidden
		ifTrue: [ self hideChildInternal: aChildElement ].
	
	controller attachChild: aChildElement at: offset