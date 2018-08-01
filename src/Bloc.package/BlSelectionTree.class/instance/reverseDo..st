tree - enumerating
reverseDo: aBlock
	self hasRoot
		ifTrue: [ self root reverseDo: aBlock ]