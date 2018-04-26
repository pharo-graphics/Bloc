builder commands
curveVia: aPoint to: aPoint2 
	self addSegment: ((BlSvgPathQuadraticBezierSegment absolute: absolute) viaPoint: aPoint; curveTo: aPoint2)