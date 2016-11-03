geometry testing
containsGlobalPoint: aPoint
	(self geomBoundsInSpace containsPoint: aPoint)
		ifFalse: [ ^ false ].
	^ self containsPoint: (self globalPointToLocal: aPoint)