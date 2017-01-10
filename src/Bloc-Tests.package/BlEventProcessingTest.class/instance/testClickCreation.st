tests
testClickCreation
	self sendInsideTargetEvent: (BlMouseDownEvent new button: BlMouseEvent primaryButton).
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true.

	self sendInsideTargetEvent: (BlMouseUpEvent new button: BlMouseEvent primaryButton).
	self assertFiredEventIs: BlMouseUpEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlClickEvent target: self child withPropagation: true.
	
	self child scaleBy: 2.
	self sendEvent: (BlMouseDownEvent new button: BlMouseEvent primaryButton; position: 150@150).
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true