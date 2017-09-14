path commands
curveVia: cp1 and: cp2 to: aPoint
	previousControlPoint := cp2.
	self computePoints: {cp1. cp2. aPoint}