tests
testMouseMove
	
	self sendInsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlMouseOverEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseEnterEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseEnterEvent target: self root withPropagation: false.
	self assertFiredEventIs: BlMouseMoveEvent target: self child withPropagation: true.
	
	self sendOutsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlMouseOutEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseLeaveEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseOverEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlMouseMoveEvent target: self root withPropagation: true.