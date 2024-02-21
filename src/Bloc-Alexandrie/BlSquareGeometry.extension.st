Extension { #name : #BlSquareGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlSquareGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		cairoContext rectangle: aBlElement geometryBounds ]

]
