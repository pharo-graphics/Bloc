builder commands
lineTo: aPoint
	self addSegment: ((BlSvgPathLineSegment absolute: absolute) lineTo: aPoint)