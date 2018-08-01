tree - enumerating
reverseDo: aBlock

	self hasRight
		ifTrue: [ self right reverseDo: aBlock ].
	
	aBlock value: self selection.
	
	self hasLeft
		ifTrue: [ self left reverseDo: aBlock ]