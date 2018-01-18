tests
testClickCreation
	self sendInsideTargetEvent: (BlMouseDownEvent primary).
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true.

	self sendInsideTargetEvent: (BlMouseUpEvent primary).
	self assertFiredEventIs: BlMouseUpEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlClickEvent target: self child withPropagation: true.
	
	self child transform
		scaleBy: 2@2;
		apply.
	self sendEvent: (BlMouseDownEvent primary position: 100@100).
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true