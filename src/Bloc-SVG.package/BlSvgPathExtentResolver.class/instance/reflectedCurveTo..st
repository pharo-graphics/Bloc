path commands
reflectedCurveTo: aPoint
	|collection|
	collection := OrderedCollection new.
	previousControlPoint ifNotNil: [collection add: (previousPoint * 2 - previousControlPoint)].
	collection add: aPoint.
	
	self computePoints: collection