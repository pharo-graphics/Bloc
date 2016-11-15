hook
attachedTo: anObject
	self assert: anObject isNotNil.
	self assert: context isNil.
	
	context := anObject