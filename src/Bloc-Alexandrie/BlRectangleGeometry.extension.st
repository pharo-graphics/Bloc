Extension { #name : #BlRectangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlRectangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedPathWith: [ :cairoContext |
		cairoContext rectangleTo: aBlElement extent ]

]

{ #category : #'*Bloc-Alexandrie' }
BlRectangleGeometry >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [ 

	| theExtent |
	theExtent := aBlElement extent.

	aeCanvas
		drawClosedPathWith: [ :cairoContext |
			cairoContext rectangleTo: theExtent ]
		borderPathWith: [ :cairoContext |
			| halfBorderWidth |
			halfBorderWidth := aWidth / 2.0.
			cairoContext
				rectangleX: halfBorderWidth
				y: halfBorderWidth
				width:  theExtent x - aWidth
				height: theExtent y - aWidth ]
]

{ #category : #'*Bloc-Alexandrie' }
BlRectangleGeometry >> aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [ 

	| theExtent negatedHalfBorderWidth |
	theExtent := aBlElement extent.
	negatedHalfBorderWidth := aWidth / -2.0.

	aeCanvas
		drawClosedPathWith: [ :cairoContext |
			cairoContext rectangleTo: theExtent ]
		borderPathWith: [ :cairoContext |
			cairoContext
				rectangleX: negatedHalfBorderWidth
				y: negatedHalfBorderWidth
				width:  theExtent x + aWidth
				height: theExtent y + aWidth ]
]
