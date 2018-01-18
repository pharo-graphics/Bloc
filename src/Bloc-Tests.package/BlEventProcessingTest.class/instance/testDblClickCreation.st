tests
testDblClickCreation

	self sendInsideTargetEvent: (BlMouseDownEvent primary).
	self assertFiredEventIs:  BlMouseDownEvent target: self child withPropagation: true.
	
	self sendInsideTargetEvent: (BlMouseUpEvent primary).
	self assertFiredEventIs:  BlMouseUpEvent target: self child withPropagation: true.
	self assertFiredEventIs:  BlClickEvent target: self child withPropagation: true.
	
	self sendInsideTargetEvent: (BlMouseDownEvent primary).
	self assertFiredEventIs:  BlMouseDownEvent target: self child withPropagation: true.
	
	self sendInsideTargetEvent: (BlMouseUpEvent primary).
	self assertFiredEventIs:  BlMouseUpEvent target: self child withPropagation: true.
	self assertFiredEventIs:  BlDblClickEvent target: self child withPropagation: true.