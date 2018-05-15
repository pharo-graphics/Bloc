children accessing
withParentsDo: aBlock
	"Evaluate a block with me and all my parents as an argument starting from me
	up to the top most parent"
	
	aBlock value: self.
	self parentsDo: aBlock