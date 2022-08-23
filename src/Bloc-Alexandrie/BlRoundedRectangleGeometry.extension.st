Extension { #name : #BlRoundedRectangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlRoundedRectangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedCurvedPathWith: [ :cairoContext |
		cairoContext
			roundedRectangleTo: self extent
			radii: cornerRadii asArray ]

]
