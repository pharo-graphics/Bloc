builder commands
moveTo: aPoint
	self addSegment: ((BlSvgPathMoveSegment absolute: absolute) moveTo: aPoint)