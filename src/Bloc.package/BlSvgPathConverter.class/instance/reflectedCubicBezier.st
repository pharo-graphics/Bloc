operations
reflectedCubicBezier

"
S/s (x2 y2 x y)+

cubic Bézier curve from the current point to (x,y). The first control point is assumed to be the reflection of the second control point on the previous command relative to the current point. (If there is no previous command or if the previous command was not an C, c, S or s, assume the first control point is coincident with the current point.) (x2,y2) is the second control point (i.e., the control point at the end of the curve). S (uppercase) indicates that absolute coordinates will follow; s (lowercase) indicates that relative coordinates will follow. Multiple sets of coordinates may be specified to draw a polybézier. At the end of the command, the new current point becomes the final (x,y) coordinate pair used in the polybézier.
"
	| p1 p2 |
	
	p1 := self readPoint.
	p2 := self readPoint.
	
	p2 ifNil: [ self error: 'Invalid path data: 2 points expected for reflected cubic bezier '].

	self reflectedCurveVia: p1 to: p2. 
	
	[ 
		(p1 := self readPoint) ifNil: [ ^ self ].
		p2 := self readPoint.

		p2 ifNil: [ self error: 'Invalid path data: 2 points expected for reflected cubic bezier '].
		self reflectedCurveVia: p1 to: p2. 
	] repeat.

