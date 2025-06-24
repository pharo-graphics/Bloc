Extension { #name : #BlRoundedRectangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlRoundedRectangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		| radii |
		radii := self nonOverlappingCornersForBorderWidth: aBlElement border width.
		
		cairoContext
			roundedRectangleLeft: 0.0
			top: 0.0
			right: extent x
			bottom: extent y
			tl: radii topLeft   
			tr: radii topRight
			br: radii bottomRight
			bl: radii bottomLeft ]

]

{ #category : #'*Bloc-Alexandrie' }
BlRoundedRectangleGeometry >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: borderWidth [

	aeCanvas borderPathFactory: [ :cairoContext | 
		| halfBorderWidth radii |
		halfBorderWidth := borderWidth / 2.0.

		radii := self nonOverlappingCornersForBorderWidth: borderWidth.
		radii := radii copyExpandedBy: halfBorderWidth negated.

		cairoContext
			roundedRectangleLeft: halfBorderWidth
			top: halfBorderWidth
			right: extent x - halfBorderWidth
			bottom: extent y - halfBorderWidth
			tl: radii topLeft
			tr: radii topRight
			br: radii bottomRight
			bl: radii bottomLeft ]
]

{ #category : #'*Bloc-Alexandrie' }
BlRoundedRectangleGeometry >> aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement borderWidth: borderWidth [

	aeCanvas borderPathFactory: [ :cairoContext | 
		| halfBorderWidth halfBorderWidthNegated radii |
		halfBorderWidth := borderWidth / 2.0.
		halfBorderWidthNegated := halfBorderWidth negated.

		radii := self nonOverlappingCornersForBorderWidth: borderWidth.
		radii := radii copyExpandedBy: halfBorderWidth.

		cairoContext
			roundedRectangleLeft: halfBorderWidthNegated
			top: halfBorderWidthNegated
			right: extent x + halfBorderWidth
			bottom: extent y + halfBorderWidth
			tl: radii topLeft
			tr: radii topRight
			br: radii bottomRight
			bl: radii bottomLeft ]
]

{ #category : #'*Bloc-Alexandrie' }
BlRoundedRectangleGeometry >> aeSetUpGradientShadowOn: aBlGradientShadowEffect extent: aPoint [

	aBlGradientShadowEffect
		setUpRoundedRectangleExtent: aPoint
		radii: cornerRadii
]
