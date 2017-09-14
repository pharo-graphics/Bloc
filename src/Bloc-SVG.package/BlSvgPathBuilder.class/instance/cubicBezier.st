operations
cubicBezier


"
C/c (x1 y1 x2 y2 x y)+

Draws a cubic Bézier curve from the current point to (x,y) using (x1,y1) as the control point at the beginning of the curve and (x2,y2) as the control point at the end of the curve. 
C (uppercase) indicates that absolute coordinates will follow; c (lowercase) indicates that relative coordinates will follow. Multiple sets of coordinates may be specified to draw a polybézier. 
At the end of the command, the new current point becomes the final (x,y) coordinate pair used in the polybézier.
"
	| p1 p2 p3 |
	
	p1 := self readPoint.
	p2 := self readPoint.
	p3 := self readPoint.
	
	p3 ifNil: [ self error: 'Invalid path data: 3 points expected for cubic bezier '].

	self curveVia: p1 and:  p2 to: p3. 
	
	[ 
		(p1 := self readPoint) ifNil: [ ^ self ].
		p2 := self readPoint.
		p3 := self readPoint.

		p3 ifNil: [ self error: 'Invalid path data: 3 points expected for cubic bezier '].
		self curveVia: p1 and:  p2 to: p3. 
	] repeat.

