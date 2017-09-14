path commands
curveVia: cp1 to: aPoint
	previousControlPoint := cp1.
	self computePoints: {cp1. aPoint}