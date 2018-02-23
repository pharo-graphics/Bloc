geometry testing
containsPoint: aPoint
	<return: #Boolean>

	(self geometryBounds containsPoint: aPoint)
		ifFalse: [ ^ false ].

	^ self geometry containsPoint: aPoint in: self