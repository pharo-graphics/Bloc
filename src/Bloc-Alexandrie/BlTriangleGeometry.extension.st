Extension { #name : #BlTriangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlTriangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedPathWith: [ :cairoContext |
		| thePoints |
		thePoints := self computeVertices.

		cairoContext
			moveTo: thePoints first;
			lineTo: thePoints second;
			lineTo: thePoints third;
			closePath ]

]

{ #category : #'*Bloc-Alexandrie' }
BlTriangleGeometry >> aeContainsPoint: aPoint in: aBlElement [

	^ BAPolygonHitTester doPolygonBy: self computeVertices include: aPoint
]
