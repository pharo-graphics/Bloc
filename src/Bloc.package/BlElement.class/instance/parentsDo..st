children accessing
parentsDo: aBlock
	"Evaluate a block with my every parent as an argument starting from my direct parent
	up to the top most parent (excluding myself).
	If I don't have a parent - does nothing"
	
	self hasParent
		ifFalse: [ ^ self ].
		
	aBlock value: self parent.
	self parent parentsDo: aBlock