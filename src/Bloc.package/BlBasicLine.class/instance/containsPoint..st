geometry testing
containsPoint: aPoint
	(self geometryBounds containsPoint: aPoint)
		ifFalse: [ ^ false ].
	^ aPoint onLineFrom: self from to: self to within: 4