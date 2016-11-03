hook
detachedFrom: anElement
	self assert: element isNotNil.
	self assert: anElement isNotNil.
	self assert: element == anElement.

	element := anElement