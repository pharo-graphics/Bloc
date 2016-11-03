hook
attachedTo: anElement
	self assert: element isNil.
	self assert: anElement isNotNil.
	
	element := anElement