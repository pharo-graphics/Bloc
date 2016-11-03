geometry testing
containsPoint: aPoint
	(self geomBounds containsPoint: aPoint)
		ifFalse: [ ^ false ].
	^ aPoint onLineFrom: self from to: self to within: 4