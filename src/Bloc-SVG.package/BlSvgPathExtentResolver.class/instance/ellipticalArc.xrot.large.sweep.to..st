path commands
ellipticalArc: radii xrot: rotation large: largeFlag sweep: sweepFlag to: pt
	|max min|
	max:= pt + (radii * 2).
	min:= pt - (radii * 2).

	self computePoints: { max. min. pt.}