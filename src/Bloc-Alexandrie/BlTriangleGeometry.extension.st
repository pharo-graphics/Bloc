Extension { #name : #BlTriangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlTriangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: true
		hasCaps: false
		block: [ :cairoContext |
			| thePoints |
			thePoints := self computeVertices.

			cairoContext
				moveTo: thePoints first;
				lineTo: thePoints second;
				lineTo: thePoints third;
				primClosePath ]

]

{ #category : #'*Bloc-Alexandrie' }
BlTriangleGeometry >> aeContainsPoint: aPoint in: aBlElement [

	^ BAOffscreen instance
		  is: aPoint
		  inFillOfVertices: self computeVertices
]
