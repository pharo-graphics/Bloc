tests
testFocus
	self assert: self child focused not.
	self assert: self root focused not.

	self child requestFocus.
	
	self assertFiredEventIs: BlFocusInEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlFocusEvent target: self child withPropagation: true.
	self assert:self child focused.
	self assert: self root focused not.
	
	self root requestFocus.
	
	self assertFiredEventIs: BlFocusOutEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlBlurEvent target: self child withPropagation: true.
	
	self assertFiredEventIs: BlFocusInEvent target: self root withPropagation: false.
	self assertFiredEventIs: BlFocusEvent target: self root withPropagation: true.
	
	self assert:self child focused not.
	self assert: self root focused.