Extension { #name : #BlSquareGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlSquareGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: true
		hasCaps: false
		block: [ :cairoContext |
			cairoContext rectangle: aBlElement geometryBounds ]

]
