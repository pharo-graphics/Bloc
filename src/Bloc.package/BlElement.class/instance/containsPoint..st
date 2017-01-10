geometry testing
containsPoint: aPoint
	(self geometryBounds containsPoint: aPoint)
		ifFalse: [ ^ false ].
	^ self geometry containsPoint: aPoint within: self geometryBounds