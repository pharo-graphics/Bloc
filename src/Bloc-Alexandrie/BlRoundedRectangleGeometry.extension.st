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
				roundedRectangleOrigin: halfBorderWidth asPoint
				extent: extent - halfBorderWidth
				radii: (cornerRadii asArrayExpandedBy: halfBorderWidth negated) ]

]

{ #category : #'*Bloc-Alexandrie' }
BlRoundedRectangleGeometry >> aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement borderWidth: borderWidth [


	aeCanvas
		drawClosedCurvedPathWith: [ :cairoContext | 
			cairoContext roundedRectangleTo: extent radii: cornerRadii asArray ]
		borderPathWith: [ :cairoContext | 
			| halfBorderWidth |
			halfBorderWidth := borderWidth / 2.0.
			cairoContext
				roundedRectangleOrigin: halfBorderWidth negated asPoint
				extent: extent + halfBorderWidth
				radii: (cornerRadii asArrayExpandedBy: halfBorderWidth) ]
]
