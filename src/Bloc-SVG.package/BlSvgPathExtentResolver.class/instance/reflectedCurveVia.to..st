path commands
reflectedCurveVia: cp2 to: aPoint
	previousControlPoint := cp2.
	self computePoints: {cp2. aPoint}