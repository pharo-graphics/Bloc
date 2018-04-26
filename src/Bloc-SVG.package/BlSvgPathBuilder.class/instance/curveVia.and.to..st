builder commands
curveVia: aPoint and: aPoint2 to: aPoint3 
	self addSegment: ((BlSvgPathCubicBezierSegment absolute: absolute) firstViaPoint: aPoint; secondViaPoint: aPoint2; curveTo: aPoint2)