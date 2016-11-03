computing
orderPreserved: aBoolean
	self assert: aBoolean isNotNil.
	
	orderPreserved := aBoolean.
	self invalidateStructure