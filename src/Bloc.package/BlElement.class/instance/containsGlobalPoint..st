geometry testing
containsGlobalPoint: aPoint
	(self geometryBoundsInSpace containsPoint: aPoint)
		ifFalse: [ ^ false ].
	^ self containsPoint: (self globalPointToLocal: aPoint)