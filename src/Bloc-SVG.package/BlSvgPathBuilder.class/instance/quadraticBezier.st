operations
quadraticBezier 


"
Q/q (x1 y1 x y)+

Draws a quadratic Bézier curve from the current point to (x,y) using (x1,y1) as the control point. Q (uppercase) indicates that absolute coordinates will follow; q (lowercase) indicates that relative coordinates will follow. Multiple sets of coordinates may be specified to draw a polybézier. At the end of the command, the new current point becomes the final (x,y) coordinate pair used in the polybézier."
	| p1 p2 |
	
	p1 := self readPoint.
	p2 := self readPoint.
	
	p2 ifNil: [ self error: 'Invalid path data: 2 points expected for quadratic bezier '].
	
	self curveVia: p1 to: p2. 
	
	[ 
		(p1 := self readPoint) ifNil: [ ^ self ].
		p2 := self readPoint.

		p2 ifNil: [ self error: 'Invalid path data: 2 points expected for quadratic bezier '].
		self curveVia: p1 to: p2. 
	] repeat.

