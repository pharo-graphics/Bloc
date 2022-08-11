Extension { #name : #BlRoundedRectangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlRoundedRectangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: false
		hasCaps: false
		block: [ :cairoContext |
			cairoContext
				roundedRectangleTo: self extent
				radii: cornerRadii asArray ]

]
