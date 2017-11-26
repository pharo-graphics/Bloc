tests
testClickCreation
	self sendInsideTargetEvent: (BlMouseDownEvent new button: BlMouseEvent primaryButton).
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true.

	self sendInsideTargetEvent: (BlMouseUpEvent new button: BlMouseEvent primaryButton).
	self assertFiredEventIs: BlMouseUpEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlClickEvent target: self child withPropagation: true.
	
	self child transform
		scaleBy: 2@2;
		apply.
	self sendEvent: (BlMouseDownEvent new button: BlMouseEvent primaryButton; position: 100@100).
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true