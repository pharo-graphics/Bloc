geometry testing
containsPoint: aPoint
	(self geometryBounds containsPoint: aPoint)
		ifFalse: [ ^ false ].
	^ true