Extension { #name : #BlRoundedRectangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlRoundedRectangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedCurvedPathWith: [ :cairoContext |
		cairoContext
			roundedRectangleTo: self extent
			radii: cornerRadii asArray ]

]

{ #category : #'*Bloc-Alexandrie' }
BlRoundedRectangleGeometry >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: borderWidth [ 

	aeCanvas
		drawClosedCurvedPathWith: [ :cairoContext |
			cairoContext
				roundedRectangleTo: extent
				radii: cornerRadii asArray ]
		borderPathWith: [ :cairoContext |
			| halfBorderWidth |
			halfBorderWidth := borderWidth / 2.0.
			cairoContext
				roundedRectangle: (halfBorderWidth asPoint extent: extent - borderWidth)
				radii: (cornerRadii asArrayExpandedBy: halfBorderWidth negated) ]

]

{ #category : #'*Bloc-Alexandrie' }
BlRoundedRectangleGeometry >> aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement borderWidth: borderWidth [ 

	| halfBorderWidth |
	halfBorderWidth := borderWidth/2.0.

	aeCanvas
		drawClosedCurvedPathWith: [ :cairoContext |
			cairoContext
				roundedRectangleTo: extent
				radii: cornerRadii asArray ]
		borderPathWith: [ :cairoContext |
			cairoContext
				roundedRectangle: (halfBorderWidth negated asPoint extent: extent + borderWidth)
				radii: (cornerRadii asArrayExpandedBy: halfBorderWidth) ]

]
