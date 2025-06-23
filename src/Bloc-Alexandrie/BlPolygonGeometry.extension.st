Extension { #name : #BlPolygonGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlPolygonGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		"Cairo treats first lineTo: as a moveTo:"
		vertices do: [ :each | cairoContext lineTo: each ].
		cairoContext closePath ]
]

{ #category : #'*Bloc-Alexandrie' }
BlPolygonGeometry >> aeSetUpGradientShadowOn: aBlGradientShadowEffect extent: aPoint [

	aBlGradientShadowEffect
		setUpPolygon: vertices
		extent: aPoint
]
