operations
ellipticalArc 


"
A (absolute) a (relative)

elliptical arc
(rx ry x-axis-rotation large-arc-flag sweep-flag x y)+
Draws an elliptical arc from the current point to (x, y). The size and orientation of the ellipse are defined by two radii (rx, ry) and an x-axis-rotation, which indicates how the ellipse as a whole is rotated relative to the current coordinate system. The center (cx, cy) of the ellipse is calculated automatically to satisfy the constraints imposed by the other parameters. large-arc-flag and sweep- flag contribute to the automatic calculations and help determine how the arc is drawn.
"
	| r xrot large sweep pt |
	
	[
	r := self readPoint.
	r ifNil: [ ^ self ].
	
	self skipBlanksAndComma.
	
	xrot := self nextNumber.

	self skipBlanksAndComma.
	
	large := self nextNumber.

	self skipBlanksAndComma.

	sweep := self nextNumber.
	
	pt := self readPoint.
	
	pt ifNil: [ self error: 'Invalid path data for elliptical arc segment'].

	self ellipticalArc: r xrot: xrot large: large sweep: sweep to: pt.
	] repeat.

