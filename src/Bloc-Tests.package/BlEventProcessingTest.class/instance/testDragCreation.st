tests
testDragCreation
	self sendInsideTargetEvent: BlMouseDownEvent primary.
	self assertFiredEventIs: BlMouseDownEvent target: self child withPropagation: true.
	
	self sendInsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlMouseMoveEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseEnterEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseEnterEvent target: self root withPropagation: false.
	self assertFiredEventIs: BlMouseOverEvent target: self child withPropagation: true.
	
	self sendOutsideTargetEvent: BlMouseMoveEvent primary.
	self assertFiredEventIs: BlDragStartEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlMouseLeaveEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlMouseOverEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlDragLeaveEvent target: self child withPropagation: false.
	self assertFiredEventIs: BlDragOverEvent target: self root withPropagation: true.
	
	self sendOutsideTargetEvent: BlMouseUpEvent primary.
	self assertFiredEventIs: BlDragEndEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlDropEvent target: self root withPropagation: true