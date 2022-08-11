Extension { #name : #BlRectangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlRectangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: true
		hasCaps: false
		block: [ :cairoContext |
			cairoContext rectangleTo: aBlElement extent ]

]
