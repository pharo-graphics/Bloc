children add/remove
addChild: aChildElement at: anIndex hidden: isHidden
	"Adds a child at an index and makes it hidden if isHidden is true.
	If an Index is less or equal 0 child will be appended to the end"
	| anOffset |

	anOffset := (anIndex <= 0
		ifTrue: [ controller childrenCount + 1 ]
		ifFalse: [  (self computeOffset: anIndex) ]) max: 1.
	
	bucket insert: isHidden at: anOffset.
	
	isHidden ifTrue: [
		self hideChildInternal: aChildElement ].
	
	controller addChild: aChildElement at: anOffset