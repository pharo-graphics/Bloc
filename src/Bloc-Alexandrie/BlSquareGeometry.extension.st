Extension { #name : #BlSquareGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlSquareGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedPathWith: [ :cairoContext |
		cairoContext rectangle: aBlElement geometryBounds ]

]
