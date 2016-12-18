children add/remove
attachChild: aChildElement at: anIndex hidden: isHidden
	"Attaches aChildElement to the infinite element"

	| anOffset |
	
	anOffset := (anIndex <= 0
		ifTrue: [ controller childrenCount + 1 ]
		ifFalse: [ self computeOffset: anIndex ]) max: 1.
	
	bucket insert: isHidden at: anOffset.

	isHidden
		ifTrue: [ self hideChildInternal: aChildElement ].
	
	controller attachChild: aChildElement at: anOffset