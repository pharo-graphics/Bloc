hook
detachedFrom: anObject
	self assert: anObject isNotNil.
	self assert: context isNotNil.
	self assert: context == anObject.
	
	context := nil