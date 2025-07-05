Extension { #name : #BlEllipseGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlEllipseGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext | 
		| rect |
		rect := self geometryBounds.
		cairoContext
			ellipseWidth: rect width
			height: rect height ]
]

{ #category : #'*Bloc-Alexandrie' }
BlEllipseGeometry >> aeSetUpGradientShadowOn: aBlGradientShadowEffect extent: aPoint [

	aBlGradientShadowEffect setUpEllipse: aPoint
]
