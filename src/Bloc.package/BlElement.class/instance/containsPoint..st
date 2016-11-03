geometry testing
containsPoint: aPoint
	(self geomBounds containsPoint: aPoint)
		ifFalse: [ ^ false ].
	^ self geometry containsPoint: aPoint within: self geomBounds