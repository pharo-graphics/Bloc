Extension { #name : #BlRectangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlRectangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		cairoContext rectangleTo: aBlElement extent ]

]

{ #category : #'*Bloc-Alexandrie' }
BlRectangleGeometry >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [ 

	aeCanvas borderPathFactory: [ :cairoContext |
		| halfBorderWidth |
		halfBorderWidth := aWidth / 2.0.
		cairoContext
			rectangleX: halfBorderWidth
			y: halfBorderWidth
			width: aBlElement width - aWidth
			height: aBlElement height - aWidth ]
]

{ #category : #'*Bloc-Alexandrie' }
BlRectangleGeometry >> aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [ 

	aeCanvas borderPathFactory: [ :cairoContext |
		| negatedHalfBorderWidth |
		negatedHalfBorderWidth := aWidth / -2.0.
		cairoContext
			rectangleX: negatedHalfBorderWidth
			y: negatedHalfBorderWidth
			width:  aBlElement width + aWidth
			height: aBlElement height + aWidth ]
]

{ #category : #'*Bloc-Alexandrie' }
BlRectangleGeometry >> aeSetUpGradientShadowOn: aBlGradientShadowEffect extent: aPoint [ 
	
	aBlGradientShadowEffect setUpRectangleExtent: aPoint
]
